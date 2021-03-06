//
//  TweetsViewController.swift
//  Twitter
//
//  Created by DrDunkan on 2/20/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tweets: [Tweet]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        TwitterClient.sharedInstance.homeTimeline({(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            for tweet in tweets {
                print(tweet.text)
            }
            }, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets == nil {
            return 0
        } else {
            return tweets!.count
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PushCellDetail"{
            let cell = sender as! TweetCell
            let tweet = cell.tweet
            let destinationViewController = segue.destinationViewController as! DetailTweetViewController
            destinationViewController.tweet = tweet
        }
        
        if segue.identifier == "ReplyPush"
        {
            let cell = sender!.superview!!.superview as! TweetCell
            let tweet = cell.tweet
            let destinationViewController = segue.destinationViewController as! ReplyTweetViewController
            destinationViewController.tweet = tweet
            
        }
        if segue.identifier == "profilePush"
        {
            let cell = sender!.superview!!.superview as! TweetCell
            let tweet = cell.tweet
            let destinationViewController = segue.destinationViewController as! ProfileViewController
            destinationViewController.tweet = tweet
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
