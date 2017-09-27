//
//  ContactCell.swift
//  AddressBookManager
//
//  Created by Cocoa on 2017/9/26.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

import UIKit
import Contacts

class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var phoneContainer: UIStackView!
    private var maxShowCount: Int {
        return 2
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        headerImageView.clipsToBounds = true
        headerImageView.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(withContact contact: CNContact) {
        updatePhoneContainer(phoneNumbers: contact.phoneNumbers)
        nameLabel.text = contact.familyName + contact.middleName + contact.givenName
        if let imageData = contact.imageData {
            headerImageView.image = UIImage(data: imageData)
        } else {
            headerImageView.image = nil
            headerImageView.backgroundColor = UIColor.lightGray
        }
    }
    
    private func updatePhoneContainer(phoneNumbers: [CNLabeledValue<CNPhoneNumber>]) {
        
        phoneContainer.arrangedSubviews.forEach {
            phoneContainer.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        phoneNumbers.enumerated().forEach { (index, value) in
            if index <= maxShowCount {
                let label = UILabel()
                label.text = "电话\(index + 1): \(value.value.stringValue)"
                label.textColor = UIColor.lightGray
                label.font = UIFont.systemFont(ofSize: 13)
                phoneContainer.addArrangedSubview(label)
            }
        }
        
    }
    
}
