//
//  PreloadAdsPlugin.swift
//  Runner
//
//  Created by bui.van.hung on 05/06/2024.
//

import Flutter
import UIKit

public class PreloadAdsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "netkeiba.channel", binaryMessenger: registrar.messenger())
        let instance = PreloadAdsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method) {
        case "preloadAds":
            guard let args = call.arguments as? [String: Any],
                  let adUnitID = args["adUnitID"] as? String,
                  let type = args["adType"] as? String else {
                result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments provided.", details: nil))
                return
            }
            handlePreloadAd(adUnitID: adUnitID, adType: type, result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
    
    private func handlePreloadAd(adUnitID: String, adType: String, result: @escaping FlutterResult) {
        AdBannerPreloader.shared.createPreloadAds(adUnitID: adUnitID, adSizeType: adType)
        result(nil)
    }
}


