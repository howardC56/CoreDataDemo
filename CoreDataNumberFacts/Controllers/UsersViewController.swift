//
//  UsersViewController.swift
//  CoreDataNumberFacts
//
//  Created by Howard Chang on 4/8/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchUsers()
    }
    
    private func fetchUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createUserSegue" {
            guard let createUserVC = segue.destination as? CreateUserTableViewController else { fatalError() }
            createUserVC.delegate = self
    }
        
    }
    
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }
    
    
}

extension UsersViewController: CreateUserTableViewControllerDelegate {
    func didCreateUser(_ createUserViewController: CreateUserTableViewController, user: User) {
        users.append(user)
    }
    
    
}
