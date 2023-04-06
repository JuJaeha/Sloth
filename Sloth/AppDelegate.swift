//
//  AppDelegate.swift
//  Sloth
//
//  Created by JAEHA JU on 2023/03/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let frame = UIScreen.main.bounds
    let nav = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: frame)
        let mainView = MainViewController(nibName: nil, bundle: nil)
        nav.viewControllers = [mainView]
        self.window!.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
}
