import UIKit

public class BlockBarButtonItem : UIBarButtonItem {
    private var actionHandler: ((Void) -> Void)?
    
    public convenience init(title: String?, style: UIBarButtonItemStyle, actionHandler: ((Void) -> Void)?) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.target = self
        self.action = #selector(barButtonItemPressed)
        self.actionHandler = actionHandler
    }
    
    public convenience init(barButtonSystemItem: UIBarButtonSystemItem, actionHandler: ((Void) -> Void)?) {
        self.init(barButtonSystemItem: barButtonSystemItem, target: nil, action: nil)
        self.target = self
        self.action = #selector(barButtonItemPressed)
        self.actionHandler = actionHandler
    }
    
    func barButtonItemPressed(sender: UIBarButtonItem) {
        if let actionHandler = self.actionHandler {
            actionHandler()
        }
    }
}