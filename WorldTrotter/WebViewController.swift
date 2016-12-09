//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Ryan Anderson on 12/8/16.
//  Copyright © 2016 mranderson. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var webView: UIWebView!
    
    override func viewDidLoad() {
        webView = UIWebView()
        view = webView
        webView.loadRequest(URLRequest(url: URL(string: "http://bignerdranch.com")!))
        print("loading")
    }
    
}
