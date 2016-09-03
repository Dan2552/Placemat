//
//  UIViewController.swift
//  Pods
//
//  Created by Daniel Green on 23/07/2015.
//
//

import Foundation

public extension UIViewController {
    var isModal: Bool {
        let presentedItself = presentingViewController?.presentedViewController == self

        let inNavigationController = navigationController != nil
        let navigationPresentedItself = navigationController?.presentingViewController?.presentedViewController == self.navigationController
        let firstInNavigationController = navigationController?.viewControllers.first == self

        let tabBar = tabBarController?.presentingViewController is UITabBarController

        return presentedItself
            || (inNavigationController && navigationPresentedItself && firstInNavigationController)
            || tabBar
    }
}
