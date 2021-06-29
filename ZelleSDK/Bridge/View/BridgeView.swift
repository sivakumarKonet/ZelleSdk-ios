//
//  Fiserv
//
//  Created by omar.ata on 4/9/21.
//

import UIKit
import WebKit
import ContactsUI

public class BridgeView: UIView, BridgeDelegate {
    
    public var webView: WKWebView?
    internal var config: BridgeConfig
    internal var viewController: UIViewController
    
    //initWithFrame to init view from code
    public init(frame: CGRect, config: BridgeConfig, viewController: UIViewController) {
        self.viewController = viewController
        self.config = config
        super.init(frame: frame)
        setupView()
    }

    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        config = RawConfig(url: "")
        viewController = UIViewController()
        super.init(coder: aDecoder)
        setupView()
    }
  
    //common func to init our view
    private func setupView() {
        webView = WKWebView(frame: .zero, configuration: configureHandlers(for: self))
        addSubview(webView!)
        webView!.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            NSLayoutConstraint(item: webView!, attribute: .top,    relatedBy: .equal, toItem: self, attribute: .top,    multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView!, attribute: .left,   relatedBy: .equal, toItem: self, attribute: .left,   multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView!, attribute: .right,  relatedBy: .equal, toItem: self, attribute: .right,  multiplier: 1, constant: 0),
        ]
        NSLayoutConstraint.activate(constraints)
        
        load()
    }
    
    public func load() {
        let url = URL(string: config.url)!
        self.webView?.load(URLRequest(url: url))

    }
    
    public func evaluate(JS: String) {
        webView?.evaluateJavaScript(JS, completionHandler: nil)
    }
}

extension BridgeView : CNContactPickerDelegate {
    
    
}
