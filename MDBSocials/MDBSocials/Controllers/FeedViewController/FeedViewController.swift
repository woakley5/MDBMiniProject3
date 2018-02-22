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
    var selectedPost: Post!
    
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
        
        FirebaseDatabaseHelper.fetchPosts(withBlock: { posts in
            for p in posts.reversed(){
                self.posts.insert(p, at: 0)
            }
            self.feedTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !FirebaseAuthHelper.isLoggedIn() {
            self.performSegue(withIdentifier: "showLogin", sender: self)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            let dest = segue.destination as! DetailViewController
            dest.post = selectedPost
        }
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
        let post = posts[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.awakeFromNib()
        cell.startLoadingView()
        if post.image == nil {
            post.getPicture {
                cell.mainImageView.image = post.image
                cell.stopLoadingView()
            }
        }
        else{
            cell.mainImageView.image = post.image
        }
        cell.eventNameLabel.text = post.eventName
        FirebaseDatabaseHelper.getUserWithId(id: post.posterId!, withBlock: { user in
            cell.posterNameLabel.text = user.username
        })
        FirebaseDatabaseHelper.getInterestedUsers(postId: post.id!) { (users) in
            cell.interestedLabel.text = "Interested: " + String(describing: users.count)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = posts[indexPath.row]
        self.performSegue(withIdentifier: "showSocialDetail", sender: self)
    }
}
