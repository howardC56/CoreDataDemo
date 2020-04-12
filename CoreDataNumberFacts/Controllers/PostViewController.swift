//
//  ViewController.swift
//  CoreDataNumberFacts
//
//  Created by Howard Chang on 4/8/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchPosts()
    }

    @IBOutlet weak var tableView: UITableView!
    
    private func fetchPosts() {
        posts = CoreDataManager.shared.fetchPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let createPostVC = segue.destination as? CreatePostViewController else { fatalError() }
        createPostVC.delegate = self
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.title ?? "") \(post.number.description)"
        cell.detailTextLabel?.text = "Posted by: \(post.user?.name ?? "") "
        return cell
    }
    
}

extension PostViewController: CreatePostViewControllerDelegate {
    func didCreatePost(_ createPostVC: CreatePostViewController, post: Post) {
        posts.append(post)
    }
}
