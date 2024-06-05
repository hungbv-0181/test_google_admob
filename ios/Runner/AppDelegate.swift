import UIKit
import Flutter
import GoogleMobileAds

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    static func shared() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GeneratedPluginRegistrant.register(with: self)
        if let preloadRegistrar = registrar(forPlugin: "PreloadAdsPlugin") {
            PreloadAdsPlugin.register(with: preloadRegistrar)
        }
        
        weak var registrar = self.registrar(forPlugin: "plugins")
        if let registrar = registrar {
            let factory = FLNativeViewFactory(messenger: registrar.messenger())
            self.registrar(forPlugin: "plugins/native_view")?.register(factory, withId: "plugins/native_view")
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
