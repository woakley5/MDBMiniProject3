//
//  FeedViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    var logoutButton: UIButton!
    var feedTableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Feed"
        
        logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newPost))
        
        feedTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        feedTableView.delegate = self
        feedTableView.dataSource = self
        view.addSubview(feedTableView)
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "post")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !FirebaseAuthHelper.isLoggedIn() {
            self.performSegue(withIdentifier: "showLogin", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirebaseDatabaseHelper.listenForPosts(tableView: feedTableView, newPostBlock: { post in
            print("New Post Loaded!")
            print(post.eventName)
            self.posts.append(post)
            self.posts.reverse()
            self.feedTableView.reloadData()
        })
    }
    
    @objc func logOut(){
        FirebaseAuthHelper.logOut(view: self) {
            print("Logged out!")
            self.performSegue(withIdentifier: "showLogin", sender: self)
        }
    }
    
    @objc func newPost(){
        self.performSegue(withIdentifier: "showNewSocial", sender: self)
    }

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! FeedTableViewCell
        cell.awakeFromNib()
        let post = posts[indexPath.row]
        cell.mainImageView.image = post.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped row")
    }
}
