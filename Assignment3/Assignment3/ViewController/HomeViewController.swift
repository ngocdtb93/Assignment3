//
//  HomeViewController.swift
//  Assignment3
//
//  Created by Ngoc Do on 3/27/16.
//  Copyright © 2016 com.appable. All rights reserved.
//

import UIKit
import Spring

class HomeViewController: UIViewController {

    var tweets:[Tweet] = []
    
    @IBAction func btnLogout(sender: AnyObject) {
        TwitterClient.shareInstance.logout()
    }
    
    @IBAction func btnPost(sender: AnyObject) {
        let nextVC = storyboard?.instantiateViewControllerWithIdentifier("PostViewController") as! PostViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showLoading()
        //set up cell for table view
        tableView.estimatedRowHeight = 95
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //get tweet
        
        
        //pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refreshControlAction:"), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        loadTweet()
    }
    
    func refreshControlAction(refreshControl:UIRefreshControl){
        loadTweet()
        refreshControl.endRefreshing()
    }

    func loadTweet(){
        TwitterClient.shareInstance.homeTimeline({ (tweets:[Tweet]) in
            self.view.hideLoading()
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (err:NSError) in
            self.view.hideLoading()
            print(err.localizedDescription)
        }
    }

}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextVC = storyboard?.instantiateViewControllerWithIdentifier("DetailTweetViewController") as! DetailTweetViewController
        nextVC.tweet = tweets[indexPath.row]
        let a  = self.navigationController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

