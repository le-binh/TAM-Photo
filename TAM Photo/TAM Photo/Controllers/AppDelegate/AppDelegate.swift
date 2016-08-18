//
//  AppDelegate.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/18/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = prepareRootViewController()
        window?.makeKeyAndVisible()
        setupAppearence()
        return true
    }
    
    private func prepareRootViewController() -> UIViewController {
        let photoListViewController = PhotoListViewController(nibName: "PhotoListViewController", bundle: nil)
        return UINavigationController(rootViewController: photoListViewController)
    }
    
    private func setupAppearence() {
        UINavigationBar.appearance().translucent = false
    }
}

