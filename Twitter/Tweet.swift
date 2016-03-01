//
//  Tweet.swift
//  Twitter
//
//  Created by DrDunkan on 2/20/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var time: String?
    var InitTime: Int?
    var timeSince: String!
    var user: User?
    var favouritesCount: Int?
    var retweetCount: Int?
    var tweetID: Int
    
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        tweetID = ((dictionary["id"]!)as? Int)!
        favouritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        if let timestampString = timestampString {
            timestamp = formatter.dateFromString(timestampString)
        }
        let now = NSDate()
        let then = timestamp
        InitTime = Int(now.timeIntervalSinceDate(then!))
        
        if InitTime >= 86400 {
            timeSince = String(InitTime! / 86400)+"d"
        }
        if (3600..<86400).contains(InitTime!) {
            timeSince = String(InitTime!/3600)+"h"
        }
        if (60..<3600).contains(InitTime!) {
            timeSince = String(InitTime!/60)+"m"
        }
        if InitTime < 60 {
            timeSince = String(InitTime!)+"s"
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
       var tweets = [Tweet]()
    
    for dictionary in dictionaries {
        let tweet = Tweet(dictionary: dictionary)
    
        tweets.append(tweet)
    }
    return tweets
    
    }

}
