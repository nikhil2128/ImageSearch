//
//  UIUtils.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class UIUtils: NSObject {
    
    static func showAlert(title:String?, message:String?, cntrllr:UIViewController){
        
        var alert:UIAlertController
        
        if message != nil {
            alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        } else {
            alert = UIAlertController(title: title, message: "Something went wrong", preferredStyle: UIAlertController.Style.alert)
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        cntrllr.present(alert, animated: true, completion: nil)
    }
    
    
    static func showProgressView(view:UIView, animated:Bool){
        let progressView = ProgressView(frame: CGRect(x:0,y:0,width:view.frame.size.width,height:view.frame.size.height))
        progressView.showProgressView(animated: true)
        progressView.tag = 1000
        view.addSubview(progressView)
    }
    
    static func hideProgressView(view:UIView, animated:Bool){
        let progressView = view.viewWithTag(1000) as? ProgressView

        if progressView != nil {
            progressView?.hideProgressView(animated: animated)
            progressView?.removeFromSuperview()
        }
        
    }
}
