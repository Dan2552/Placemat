import UIKit

enum NavigationError: Error {
    case WindowAlreadyExists
}

/**
 Helper class to navigate between view controllers.
 */
public class Navigation {
    var currentViewController: UIViewController
    var animated: Bool

    public init(viewController: UIViewController, animated: Bool = true) {
        currentViewController = viewController
        self.animated = animated
    }
    
    /**
     Navigate to another controller.
     
     optional:
     - **modally** - Defaults to false. If set to true, will embed the controller into a UINavigationController, and present that outside of the current navigation stack.
     */
    public func show(target: UIViewController, modally: Bool = false) {
        if modally {
            let nav = UINavigationController(rootViewController: target)
            
            let dismissCompletion: (() -> Void) = {
                target.navigationItem.leftBarButtonItem = BlockBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel) {
                    Navigation(viewController: target).dismiss()
                }
            }
            
            currentViewController.present(nav,
                                          animated: animated,
                                          completion: dismissCompletion)
        } else {
            if let navigation = currentViewController.navigationController {
                navigation.pushViewController(target, animated: animated)
            } else {
                currentViewController.present(target,
                                              animated: animated,
                                              completion: nil)
            }
        }
    }

    /**
     Dismisses the view controller. Automatically determines how the controller should be dismissed appropriately (e.g. if it's shown modally or not)
     */
    public func dismiss() {
        if let navigation = currentViewController.navigationController {
            if navigation.viewControllers.count == 1 {
                currentViewController.dismiss(animated: animated, completion: nil)
            }
            navigation.popViewController(animated: animated)
            
        } else {
            currentViewController.dismiss(animated: animated, completion: nil)
        }
    }
    
    /**
     Used to setup a UIWindow containing the view controller.
     
     Normally this should be used within `application:didFinishLaunchingWithOptions:`.
     
     Make sure you keep a strong reference of the window.
     */
    public func setupWindow() throws -> UIWindow {
        guard currentViewController.view.window == nil else { throw NavigationError.WindowAlreadyExists }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = currentViewController
        window.makeKeyAndVisible()
        
        return window
    }
}
