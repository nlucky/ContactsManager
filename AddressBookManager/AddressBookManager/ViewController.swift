//
//  ViewController.swift
//  AddressBookManager
//
//  Created by Cocoa on 2017/9/23.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ContactManager.shared.fetchAll()
        ContactManager.shared.fetch(withType: .sameName)
        ContactManager.shared.fetch(withType: .sameNum)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

