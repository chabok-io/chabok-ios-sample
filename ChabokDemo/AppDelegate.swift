//
//  AppDelegate.swift
//  ChabokDemo
//
//  Created by Hossein Shooshtari on 6/18/21.
//

import UIKit
import ChabokKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var initState: Bool = false
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let clientId = UserDefaults.standard.string(forKey: "cid") ?? "61d16239a26a495f2c955b7a"
        let clientSecret = UserDefaults.standard.string(forKey: "sid") ?? "4uQAkADYK3GHfIyoJyFbboj1tqH2LhWYjfIk1Ejp"
        
        UserDefaults.standard.set(clientId, forKey: "cid")
        UserDefaults.standard.set(clientSecret, forKey: "sid")
        
        UserDefaults.standard.synchronize()
        Chabok.setLogLevel(logLevel: LogLevel.Verbose)
        Chabok.initialize(clientId: clientId, clientSecret: clientSecret) {
            (success:Bool,message:String) in
//            self.showInitState(state: success)
        }
        
        // Override point for customization after application launch.
        return true
    }


}

