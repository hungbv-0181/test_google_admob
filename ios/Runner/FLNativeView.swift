//
//  FLNativeView.swift
//  Runner
//
//  Created by bui.van.hung on 05/06/2024.
//

import Flutter
import UIKit
import GoogleMobileAds

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        createAdBanner(arguments: args)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createAdBanner(arguments args: Any?){
        guard let appDelegate = AppDelegate.shared(),
              let window = appDelegate.window,
              let controller = window.rootViewController else { return }
        guard let dict = args as? [String: Any],
              let adUnitID = dict["adUnitID"] as? String else { return }
        
        var ad = AdBannerPreloader.shared.getPreloadedAds(adUnitID: adUnitID)
        if ad == nil {
            print("------- createAdBanner from nil")
            let adTypeString = dict["adType"] as? String
            let adType = AdType(rawValue: adTypeString ?? "banner") ?? .banner
            let bannerView = GADBannerView(adSize: adType.getAdmobSize())
            bannerView.adUnitID = adUnitID
            bannerView.rootViewController = controller
            bannerView.load(GADRequest())
            ad = bannerView
        } else {
            print("------- createAdBanner preload")
        }
        view().addSubview(ad!)
    }
}
