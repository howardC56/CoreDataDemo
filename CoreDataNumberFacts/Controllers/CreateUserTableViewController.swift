//
//  CreateUserTableViewController.swift
//  CoreDataNumberFacts
//
//  Created by Howard Chang on 4/8/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

protocol CreateUserTableViewControllerDelegate: class {
    func didCreateUser(_ createUserViewController: CreateUserTableViewController, user: User)
}

class CreateUserTableViewController: UITableViewController {
    
    weak var delegate: CreateUserTableViewControllerDelegate?

    @IBOutlet weak var userNameTextLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let usernameText = userNameTextLabel.text, !usernameText.isEmpty else { return }
        let date = datePicker.date
        let user = CoreDataManager.shared.createUser(name: usernameText, dob: date)
        delegate?.didCreateUser(self, user: user)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
    }

}
