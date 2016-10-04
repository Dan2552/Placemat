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
    
    public func setupTableView(tableView: UITableView? = nil, style: UITableViewStyle = .Grouped) -> UITableView {
        var tableView = tableView
        
        if tableView == nil {
            tableView = UITableView(frame: view.bounds, style: style)
            tableView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(.FlexibleHeight)
            tableView?.cellLayoutMarginsFollowReadableWidth = false
        }
        if tableView?.superview == nil && view != tableView {
            view.addSubview(tableView!)
        }
        if tableView?.delegate == nil {
            tableView?.delegate = (self as! UITableViewDelegate)
        }
        if tableView?.dataSource == nil {
            tableView?.dataSource = (self as! UITableViewDataSource)
        }
        
        tableView?.reloadData()
        
        return tableView!
    }
}
