//
//  BLKBrowserViewController.swift
//  BLKSimpleWebBrowser
//
//  Created by black9 on 07/09/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

import UIKit
import WebKit

class BLKBrowserViewController: UIViewController {

    private var webView:WKWebView =  WKWebView()
    
    @IBOutlet var urlField: UITextField!
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet var bottomToolbar: UIToolbar!
    @IBOutlet var progressBar: UIProgressView!
    
    let httpValidator = BLKHTTPLinkValidator()
    
    weak var viewModel:BLKBrowserViewModel?
      private var kvoContext: UInt8 = 1
    
    func bindViewModel() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        urlField.delegate = self
        
        webView.frame = self.view.bounds
        webView.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.view.insertSubview(webView, atIndex: 0)
        let views = ["urlField": urlField, "webView": webView,"view":self.view,"toolbar":bottomToolbar]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: views)
        view.addConstraints(horizontalConstraints)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-27-[urlField]-5-[webView]-0-[toolbar]-0-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views)
        view.addConstraints(verticalConstraints)
        
        loadStringInWebView("http://google.com")
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.New, context: &kvoContext)
        webView.addObserver(self, forKeyPath: "canGoBack",
            options: NSKeyValueObservingOptions.New, context: &kvoContext)
        webView.addObserver(self, forKeyPath: "canGoForward", options: NSKeyValueObservingOptions.New, context: &kvoContext)
        
        // Do any additional setup after loading the view.'
        bindViewModel()
    }

    @IBAction func goBack(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func goForward(sender: AnyObject) {
        webView.goForward()
    }
    
    
    override func observeValueForKeyPath(keyPath: String,
        ofObject object: AnyObject, change: [NSObject : AnyObject],
        context: UnsafeMutablePointer<Void>) {
            if context == &kvoContext {
                if keyPath == "canGoBack" {
                    backButton.enabled = webView.canGoBack
                }
                else if keyPath == "canGoForward" {
                    nextButton.enabled = webView.canGoForward
             
                }
                switch (keyPath) {
                    
                    case "canGoBack" :
                        backButton.enabled = webView.canGoBack
                    
                    
                    case "canGoForward" :
                        nextButton.enabled = webView.canGoForward
                    
                    
                    case "estimatedProgress" :
                     
                        progressBar.hidden = webView.estimatedProgress < 0.1 || webView.estimatedProgress > 0.95
                        
                        progressBar.progress = Float(webView.estimatedProgress)
                    
                    default:
                    print("default")
                }
            }
    }
    
    
    deinit {
        webView.removeObserver(self, forKeyPath: "miles")
    }

    
    func loadStringInWebView(string:String) {
        if httpValidator.isValid(string) {
            if let url = NSURL(string: string) {
                let request = NSURLRequest(URL: url)
                webView.loadRequest(request)
            }
        }
    }
}

extension BLKBrowserViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        loadStringInWebView(textField.text)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

}
