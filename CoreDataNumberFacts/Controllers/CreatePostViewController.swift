//
//  CreatePostViewController.swift
//  CoreDataNumberFacts
//
//  Created by Howard Chang on 4/8/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

protocol CreatePostViewControllerDelegate: class {
    func didCreatePost(_ createPostVC: CreatePostViewController, post: Post)
}

class CreatePostViewController: UITableViewController {

    @IBOutlet weak var postTitleTextField: UITextField!
    
    @IBOutlet weak var postNumberFactTextField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let postTitle = postTitleTextField.text, !postTitle.isEmpty, let numberFactText = postNumberFactTextField.text, !numberFactText.isEmpty, let numberFact = Double(numberFactText), let user = selectedUser else { return }
        let post = CoreDataManager.shared.createPost(user: user, numberFact: numberFact, title: postTitle)
        
        delegate?.didCreatePost(self, post: post)
        dismiss(animated: true, completion: nil)
    }
    
    weak var delegate: CreatePostViewControllerDelegate?
    private var users = [User]()
    
    private var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        fetchUsers()
        selectedUser = users.first
    }
    
    private func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func fetchUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }

   

}

extension CreatePostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUser = users[row]
    }
    
}
