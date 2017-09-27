//
//  ContactDetailViewController.swift
//  AddressBookManager
//
//  Created by Cocoa on 2017/9/26.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

import UIKit
import Contacts

class ContactDetailViewController: BaseViewController {
    fileprivate var contact: CNContact
    
    public init(contact: CNContact) {
        self.contact = contact
        super.init(nibName:nil, bundle:nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
