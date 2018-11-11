//
//  BaseViewController.swift
//  ImageSearch
//
//  Created by Nikhil Bansal on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:NavigationBar Methods
    func addNavigationBarWithTitle(title:String) {
        self.navigationController?.navigationBar.barTintColor = ColorConstant.Primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)


        self.navigationItem.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorConstant.TextPrimary]
        self.navigationController?.navigationBar.isTranslucent = false
    }

}
