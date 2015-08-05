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
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
}