//
//  MenuViewController.swift
//  CVapp
//
//  Created by Prasanth pc on 2019-06-08.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

protocol MenuViewControlDelegate: NSObjectProtocol {
     func closeView(with rowSelected: Int)
}


class MenuViewController: UIViewController {
    weak var delegate: MenuViewControlDelegate?
    var sam: String!
    fileprivate let dataSource = ["Home", "Projects Handled", "Academic Qualification","References"]
    fileprivate let identifier = "identifier"
    let tableView: UITableView  = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        tableView.register(MenuBarTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
}
//MARK: - TableViewDelegates
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.closeView(with: indexPath.row)
    }
    
}
