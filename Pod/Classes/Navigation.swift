import UIKit

public class Navigation {
    var currentViewController: UIViewController
    var animated: Bool
    
    public init(viewController: UIViewController, animated: Bool = true) {
        currentViewController = viewController
        self.animated = animated
    }
    
    public func show(target: UIViewController, modally: Bool = false) {
        if modally {
            let nav = UINavigationController(rootViewController: target)
            
            let dismissCompletion: (() -> Void) = {
                target.navigationItem.leftBarButtonItem = BlockBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel) {
                    Navigation(viewController: target).dismiss()
                }
            }
            
            currentViewController.presentViewController(nav,
                                                        animated: animated,
                                                        completion: dismissCompletion)
        } else {
            if let navigation = currentViewController.navigationController {
                navigation.pushViewController(target, animated: animated)
            } else {
                currentViewController.presentViewController(target,
                                                            animated: animated,
                                                            completion: nil)
            }
        }
    }

    public func dismiss() {
        if let navigation = currentViewController.navigationController {
            if navigation.viewControllers.count == 1 {
                currentViewController.dismissViewControllerAnimated(animated, completion: nil)
            }
            navigation.popViewControllerAnimated(animated)
            
        } else {
            currentViewController.dismissViewControllerAnimated(animated, completion: nil)
        }
    }
}