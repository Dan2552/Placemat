import UIKit

public class BlockBarButtonItem : UIBarButtonItem {
    private var actionHandler: ((Void) -> Void)?
    
    public convenience init(title: String?, style: UIBarButtonItemStyle, handler: ((Void) -> Void)?) {
        self.init(title: title, style: style, target: nil, action: nil)
        target = self
        action = #selector(barButtonItemPressed)
        actionHandler = handler
    }
    
    public convenience init(barButtonSystemItem: UIBarButtonSystemItem, handler: ((Void) -> Void)?) {
        self.init(barButtonSystemItem: barButtonSystemItem, target: nil, action: nil)
        target = self
        self.action = #selector(barButtonItemPressed)
        self.actionHandler = handler
    }
    
    func barButtonItemPressed(sender: UIBarButtonItem) {
        if let handler = actionHandler {
            handler()
        }
    }
}