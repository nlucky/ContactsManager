//
//  BaseViewController.swift
//  AddressBookManager
//
//  Created by Cocoa on 2017/9/26.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

import UIKit
public func SYSTEM_VERSION_LESS_THAN(_ version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
}

class BaseViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    public override init(nibName: String?, bundle: Bundle?) {
        
        if (nibName == nil && SYSTEM_VERSION_LESS_THAN("9.0")) {
            let clazz = type(of: self)
            let className = String(describing: clazz)
            let currentBundle = bundle ?? Bundle(for:clazz)
            if let _ = currentBundle.path(forResource: className, ofType: "nib") {
                super.init(nibName: className, bundle:bundle)
            } else {
                super.init(nibName: nibName, bundle:bundle)
            }
            
        } else {
            
            super.init(nibName:nibName, bundle:bundle)
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
}
