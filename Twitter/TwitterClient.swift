//
//  TwitterClient.swift
//  Twitter
//
//  Created by DrDunkan on 2/20/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager
{
    

    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "AwvzOdrWDL4ZGDUpgulzdYKU7", consumerSecret: "JzcM0JuFbUmmH8KGetCuJRuwfI5NLGiFLK6MKbj9mzHhPxfwgj")
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterduncan://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("I got a token!")
            
        let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
        UIApplication.sharedApplication().openURL(url)
            
        }) {(error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }

    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath(("oauth/access_token"), method: "POST",
            requestToken: requestToken, success: {(accessToken:
                BDBOAuth1Credential!) -> Void in
                
                self.currentAccount({(user: User) -> () in
                    self.loginSuccess?()
                    User.currentUser = user
                    }, failure: {(error: NSError) -> () in
                        self.loginFailure?(error)
                })
                
                
            }) {(error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }

        
    }
    func logout() {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("account: \(response)")
            let userDictionary = response as! NSDictionary
            //print("name: \(user["name"])")
            
            let user = User(dictionary: userDictionary)
            success(user)
           
            
            },failure:  {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    func retweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("RetweetID: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("RT failure")
                completion(error: error)
            }
        )
    }
    
    func unretweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/unretweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("UnRetweetID: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("UNRT failure")
                completion(error: error)
            }
        )
    }
    
    func favTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("FavouriteID: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Favoriting did not work")
                completion(error: error)
            }
        )}
    func unfavTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/destroy.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("UnFavouritedID: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("UnFavoriting did not work")
                completion(error: error)
            }
        )}
    
    func tweeting(tweet: String){
        
        POST("https://api.twitter.com/1.1/statuses/update.json?status=\(tweet)", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Message Tweeted")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Tweet did not work")
                
            }
        )}
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            
            }, failure: {(task:NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }

}
