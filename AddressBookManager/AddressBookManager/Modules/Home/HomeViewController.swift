//
//  HomeViewController.swift
//  AddressBookManager
//
//  Created by Cocoa on 2017/9/26.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var dataSource = ContactManager.shared.fetchAll()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        tableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = ContactDetailViewController(contact: self.dataSource[indexPath.row])
        navigationController?.pushViewController(detail, animated: true)
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var contactCell: ContactCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactCell {
           contactCell = cell
        } else {
            contactCell = ContactCell(style: .default, reuseIdentifier: "ContactCell")
        }
        contactCell.update(withContact: dataSource[indexPath.row])
        return contactCell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (action, mindexPath) in
            ContactManager.shared.delete(contact: self.dataSource[indexPath.row])
            self.dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [mindexPath], with: .fade)
        }
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
       
    }
}
