//
//  ContactDetailViewController.swift
//  AddressBookManager
//
//  Created by Cocoa on 2017/9/26.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

import UIKit
import Contacts
import MessageUI

private enum CallType {
    case message
    case phone
    case facetime
    
}
class ContactDetailViewController: BaseViewController {
    fileprivate var contact: CNContact
    @IBOutlet weak var numbersTableView: UITableView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    public init(contact: CNContact) {
        self.contact = contact
        super.init(nibName:nil, bundle:nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if contact.phoneNumbers.count > 1 {
            showAction(withType: .message)
        } else {
            execute(withNum: contact.phoneNumbers.first?.value.stringValue, type: .message)
        }
        
    
        
    }
    @IBAction func callPhone(_ sender: Any) {
        if contact.phoneNumbers.count > 1 {
            showAction(withType: .phone)
        } else {
            execute(withNum: contact.phoneNumbers.first?.value.stringValue, type: .phone)
        }
    }
    @IBAction func callFaceTime(_ sender: Any) {
        if contact.phoneNumbers.count > 1 {
            showAction(withType: .facetime)
        } else {
            execute(withNum: contact.phoneNumbers.first?.value.stringValue, type: .facetime)
        }
    }
    


}

private extension ContactDetailViewController {
    func refresh() {
        if let data = contact.imageData {
            avatarImageView.image = UIImage(data: data)
        } else {
            avatarImageView.image = nil
        }
        nameLabel.text = contact.familyName + contact.middleName + contact.givenName
        numbersTableView.reloadData()
    }
    func showAction(withType type: CallType) {
        let ac = UIAlertController(title: "请选择手机号", message: nil, preferredStyle: .actionSheet)
        contact.phoneNumbers.forEach { phone in
            let action = UIAlertAction(title: phone.value.stringValue, style: .default, handler: {[weak self] _ in
                self?.execute(withNum: phone.value.stringValue, type: type)
            })
            ac.addAction(action)
        }
        present(ac, animated: true, completion: nil)
    }
    
    func execute(withNum num: String?, type: CallType) {
        guard let phoneNum = num else { return }

        var url: URL?
        switch type {
        case .phone:
            url = URL(string: "tel://\(phoneNum)")
            break
        case .facetime:
            url = URL(string: "facetime://\(phoneNum)")
        case .message:
            sendMessage(toNumber: phoneNum)
            
        }
        guard let finalURL = url, UIApplication.shared.canOpenURL(finalURL)  else {
            return
        }
        UIApplication.shared.openURL(finalURL)
        
        
    }
    func sendMessage(toNumber numer: String) {
        guard MFMessageComposeViewController.canSendText() else { return }
        let controller = MFMessageComposeViewController()
        controller.body = nil
        controller.recipients = [numer]
        controller.messageComposeDelegate = self
        present(controller, animated: true, completion: nil)
    }
}
extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.phoneNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
extension ContactDetailViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

}



class PhoenCell: UITableViewCell {
    private var label: UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func commonInit() {
        let label = UILabel()
        contentView.addSubview(label)
        self.label = label
    }
    
}
