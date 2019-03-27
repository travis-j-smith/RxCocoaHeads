//
//  AppDelegate.swift
//  RxCocoaHeads
//
//  Created by Travis Smith on 3/16/19.
//  Copyright © 2019 Travis Smith. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String else {
            fatalError("You must include your OMDb API key in the Info.plist as 'apiKey'")
        }
        
        let networkManager = NetworkManager(apiKey: apiKey)
        let mediaViewModel = MediaViewModel(networkManager: networkManager)
        let mediaViewController = MediaViewController(viewModel: mediaViewModel)
        let navigationController = UINavigationController(rootViewController: mediaViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
