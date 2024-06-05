//
//  AdBannerPreloader.swift
//  Runner
//
//  Created by bui.van.hung on 05/06/2024.
//

import Foundation
import GoogleMobileAds

enum AdType: String {
    case banner
    case mediumRectangle
    
    func getAdmobSize() -> GADAdSize {
        switch self {
        case .banner:
            return GADAdSizeBanner
        case .mediumRectangle:
            return GADAdSizeMediumRectangle
        }
    }
}

class AdBannerPreloader {
    static let shared = AdBannerPreloader()
    
    var preloadedAds = [GADBannerView]()
    
    func getPreloadedAds(adUnitID: String) -> GADBannerView? {
//        let ad = preloadedAds.first { $0.adUnitID == adUnitID }
//        return ad
        var ad: GADBannerView?
        var adIndex: Int?
        
        for (index, element) in preloadedAds.enumerated() {
            if element.adUnitID == adUnitID {
                ad = element
                adIndex = index
                break
            }
        }
        if let index = adIndex {
            preloadedAds.remove(at: index)
        }
        return ad
    }
    
    func createPreloadAds(adUnitID: String, adSizeType: String) {
        let adType = AdType(rawValue: adSizeType) ?? .banner
        let ad = createAdBanner(adUnitID: adUnitID, adSize: adType.getAdmobSize())
        if let ad = ad {
            preloadedAds.append(ad)
        }
        print("----- preloadedAds \(preloadedAds.count)")
    }
    
    private func createAdBanner(adUnitID: String, adSize: GADAdSize) -> GADBannerView? {
        guard let appDelegate = AppDelegate.shared(),
              let window = appDelegate.window,
              let controller = window.rootViewController else { return nil }
        let bannerView = GADBannerView(adSize: adSize)
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = controller
        bannerView.load(GADRequest())
        
        return bannerView
    }
}
