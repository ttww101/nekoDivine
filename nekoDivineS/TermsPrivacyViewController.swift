//
//  WKWebViewController.swift
//  ShanghaiFood
//
//  Created by Apple on 2019/3/30.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

import UIKit
import WebKit

class TermsPrivacyViewController: BaseViewController, WKNavigationDelegate {

    var wkView: WKWebView!
    var YesBtn: UIButton!
    var NoBtn: UIButton!
    @objc var startPage:String = ""
    var naviPages:[String] = [String]()
    var btnLeading:NSLayoutConstraint? = nil
    var btnLeading2:NSLayoutConstraint? = nil
    var btnTrailing:NSLayoutConstraint? = nil
    var btnTrailing2:NSLayoutConstraint? = nil
    var btnBottom:NSLayoutConstraint? = nil
    var btnBottom2:NSLayoutConstraint? = nil
    var btnHeight:NSLayoutConstraint? = nil
    var btnHeight2:NSLayoutConstraint? = nil
    var btnWidth:NSLayoutConstraint? = nil
    var wkLeading:NSLayoutConstraint? = nil
    var wkTrailing:NSLayoutConstraint? = nil
    var wkTop:NSLayoutConstraint? = nil
    var wkBottom:NSLayoutConstraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "隐私政策"
        self.YesBtn = UIButton(frame: CGRect(x: 0, y: 44 - self.view.frame.height, width: self.view.frame.width, height: 44))
        self.NoBtn = UIButton(frame: CGRect(x: 0, y: 44 - self.view.frame.height, width: self.view.frame.width, height: 44))
        self.YesBtn.layer.backgroundColor = self.navigationController?.navigationBar.barTintColor?.cgColor
        self.NoBtn.layer.backgroundColor = self.navigationController?.navigationBar.barTintColor?.cgColor
        self.YesBtn.setTitle("我同意隐私政策", for: UIControl.State.normal)
        self.NoBtn.setTitle("我不同意隐私政策", for: UIControl.State.normal)
        self.YesBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.NoBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.view.addSubview(self.YesBtn)
        self.view.addSubview(self.NoBtn)
        
        self.YesBtn.translatesAutoresizingMaskIntoConstraints = false
        self.NoBtn.translatesAutoresizingMaskIntoConstraints = false
        self.btnLeading = NSLayoutConstraint(item: self.YesBtn,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self.NoBtn,
                                         attribute: .trailing,
                                         multiplier: 1.0,
                                         constant: 0.0)
        self.btnTrailing = NSLayoutConstraint(item: self.YesBtn,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self.view,
                                            attribute: .trailing,
                                            multiplier: 1.0,
                                            constant: 0.0)
        self.btnBottom = NSLayoutConstraint(item: self.YesBtn,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: self.view,
                                             attribute: .bottom,
                                             multiplier: 1.0,
                                             constant: 0.0)
        
        self.btnHeight = NSLayoutConstraint(item: self.YesBtn,
                                           attribute: .height,
                                           relatedBy: .equal,
                                           toItem: nil,
                                           attribute: .notAnAttribute,
                                           multiplier: 1.0,
                                           constant: 44.0)
        
        self.btnLeading2 = NSLayoutConstraint(item: self.NoBtn,
                                             attribute: .leading,
                                             relatedBy: .equal,
                                             toItem: self.view,
                                             attribute: .leading,
                                             multiplier: 1.0,
                                             constant: 0.0)
        self.btnTrailing2 = NSLayoutConstraint(item: self.NoBtn,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self.YesBtn,
                                              attribute: .leading,
                                              multiplier: 1.0,
                                              constant: 0.0)
        self.btnBottom2 = NSLayoutConstraint(item: self.NoBtn,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.view,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: 0.0)
        
        self.btnHeight2 = NSLayoutConstraint(item: self.NoBtn,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: 44.0)
        
        self.btnWidth = NSLayoutConstraint(item: self.NoBtn,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: self.YesBtn,
                                             attribute: .width,
                                             multiplier: 1.0,
                                             constant: 44.0)
        
        
        self.view.addConstraints([self.btnLeading!,self.btnTrailing!,self.btnBottom!,self.btnLeading2!,self.btnTrailing2!,self.btnBottom2!,self.btnWidth!])
        self.YesBtn.addConstraint(self.btnHeight!)
        self.NoBtn.addConstraint(self.btnHeight2!)
        self.YesBtn.addTargetClosure { (sender) in
            self.dismiss(animated: true, completion: nil)
        }
        self.NoBtn.addTargetClosure { (sender) in
            exit(0)
        }
        self.wkView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 44))
        self.view.addSubview(self.wkView)
        self.wkView.translatesAutoresizingMaskIntoConstraints = false
        self.wkLeading = NSLayoutConstraint(item: self.wkView,
                                             attribute: .leading,
                                             relatedBy: .equal,
                                             toItem: self.view,
                                             attribute: .leading,
                                             multiplier: 1.0,
                                             constant: 0.0)
        self.wkTrailing = NSLayoutConstraint(item: self.wkView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self.view,
                                              attribute: .trailing,
                                              multiplier: 1.0,
                                              constant: 0.0)
        self.wkTop = NSLayoutConstraint(item: self.wkView,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: self.view,
                                            attribute: .top,
                                            multiplier: 1.0,
                                            constant: 0.0)
        
        self.wkBottom = NSLayoutConstraint(item: self.wkView,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.YesBtn,
                                            attribute: .top,
                                            multiplier: 1.0,
                                            constant: 0.0)
        
        self.view.addConstraints([self.wkLeading!,self.wkTrailing!,self.wkTop!,self.wkBottom!])
        self.wkView.navigationDelegate = self
        
        YesBtn.addTargetClosure { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let url:URL = URL(string: startPage) {
            let request:URLRequest = URLRequest(url: url)
            self.wkView.load(request)
        }
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        if let page = webView.url {
            print(page.absoluteString)
            if (startPage.count == 0) {
                naviPages = [String]()
                startPage = page.absoluteString
            }
            if (naviPages.count > 1) {
                if (naviPages[naviPages.count - 2] == page.absoluteString) {
                    naviPages.removeLast()
                } else {
                    naviPages.append(page.absoluteString)
                }
            } else {
                naviPages.append(page.absoluteString)
            }
            
            
            if (naviPages.count > 1) {
                DispatchQueue.main.async {
                    self.navigationController?.setNavigationBarHidden(true, animated: false)
                    self.btnHeight!.constant = 0
                }
            } else {
                DispatchQueue.main.async {
                    self.navigationController?.setNavigationBarHidden(false, animated: false)
                    self.btnHeight!.constant = 44
                }
            }
        }
        
    }

}
