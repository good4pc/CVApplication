//
//  CompanyWebsiteShowingViewController.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-09.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit
import WebKit

class CompanyWebsiteShowingViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var webSiteUrl: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        guard let _websiteUrl = webSiteUrl else {
            showAlert()
            return
        }
        guard let url = URL(string: _websiteUrl) else {
            showAlert()
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: alertTitle, message: unableToLoadWebsiteData, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertOkButton, style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CompanyWebsiteShowingViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.removeActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.view.addActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.view.removeActivityIndicator()
        showAlert()
    }
}
