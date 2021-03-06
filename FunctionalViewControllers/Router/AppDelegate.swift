//
//  AppDelegate.swift
//  Router
//
//  Created by Carsten Könemann on 24.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Override point for customization after application launch.

        let colorViewController = ColorViewController()
            .push(.spaceGrey, route: { SizeViewController(color: $0)
                .push(.gb32, route: { _ in ColorViewController() })
                .push(.gb128, route: { _ in ColorViewController() })
            })
            .push(.roseGold, route: { SizeViewController(color: $0) })

        window = UIWindow(frame: UIScreen.main().bounds)
        window?.rootViewController = UINavigationController(rootViewController: colorViewController)
        window?.makeKeyAndVisible()

        return true
    }

}
