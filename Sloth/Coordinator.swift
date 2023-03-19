//
//  Coordinator.swift
//  Sloth
//
//  Created by JAEHA JU on 2023/03/11.
//

import UIKit

class Coordinator {
    
    let window:UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewController = RootViewController()
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        self.window.rootViewController = navigationRootViewController
        self.window.makeKeyAndVisible()
    }
    
}
