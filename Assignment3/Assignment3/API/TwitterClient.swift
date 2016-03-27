//
//  TwitterClient.swift
//  Assignment3
//
//  Created by Ngoc Do on 3/27/16.
//  Copyright © 2016 com.appable. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

class TwitterClient: BDBOAuth1SessionManager {
    static let shareInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: myConsumerKey, consumerSecret: myConsumerSecret)
    var loginSuccess: ( ()-> () )?
    var loginFailure: ( (NSError) -> () )?
    
    func currentAccount(success:(User)-> (), failure:(NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, success: { (task:NSURLSessionDataTask, respone:AnyObject?) in
            if let userDict:NSDictionary = respone as? NSDictionary{
                let user = User(dict: userDict)
                success(user)
            }
            }, failure: { (task: NSURLSessionDataTask?, err:NSError) in
                print("Error: \(err.localizedDescription)")
                failure(err)
        })
    }
    
    
    func homeTimeline(success:([Tweet] ->()), failure:(NSError) ->()){
        GET("1.1/statuses/home_timeline.json?count=20", parameters: nil, success: { (task:NSURLSessionDataTask, respone:AnyObject?) in
            let dicts = respone as? [NSDictionary]
            let tweets = Tweet.tweetFromArray(dicts!)
            success(tweets)
            
            }, failure: { (task:NSURLSessionDataTask?, err:NSError) in
                print("Error: \(err.localizedDescription)")
                failure(err)
        })

    }

    
    func postTweet(text:String,success:(() ->()), failure:(NSError) ->()){
        
        var params = [String : AnyObject]()
        params["status"] = text
        POST("https://api.twitter.com/1.1/statuses/update.json", parameters: params, success: { (task:NSURLSessionDataTask, respone:AnyObject?) in
            let dicts = respone as? NSDictionary
            success()
            
            
            }, failure: { (task:NSURLSessionDataTask?, err:NSError) in
                print("Error: \(err.localizedDescription)")
                failure(err)
        })
        
    }
    
    func login(success:() -> (), failure:(NSError) ->()){
        loginSuccess = success
        loginFailure = failure
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "MyAssignment3://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) in
            let urlAuthorize = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(urlAuthorize)
            
            
        }) { (err:NSError!) in
            print("Error: \(err.localizedDescription)")
            self.loginFailure?(err)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
    }
    
    func handleOpenUrl(url:NSURL){
        let request = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: request, success: { (accessToken:BDBOAuth1Credential!) in
            //get current user
            self.currentAccount({ (user:User) in
                User.currentUser = user//set
                self.loginSuccess?()
            }, failure: { (err:NSError) in
                self.loginFailure?(err)
            })
            
            
            
        }) { (err: NSError!) in
            self.loginFailure?(err)
        }
    }
    
    func favoriteTweet(isCreate:Bool, id: Int, completion: ( error: NSError?) -> ()) {
        
        var params = [String : AnyObject]()
        params["id"] = id
        var link = ""
        if( isCreate){
            link = "1.1/favorites/create.json"
        }else{
            link = "1.1/favorites/destroy.json"
        }
        
        POST(link, parameters: params, success: { (task:NSURLSessionDataTask, reponse:AnyObject?) in
            print("success")
            completion(error: nil)
        }) { (task:NSURLSessionDataTask?, err:NSError) in
            print("error")
            completion(error: err)
        }
        
    }
    
    //1.1/statuses/retweet/:id.json
    
    
    func retweetTweet(isCreate:Bool, id: Int, completion: ( error: NSError?) -> ()) {
        
        var params = [String : AnyObject]()
        params["id"] = id
        var link = ""
        if( isCreate){
            link = "1.1/statuses/retweet/\(id).json"
        }else{
            link = "1.1/statuses/unretweet/\(id).json"
        }
        
        POST(link, parameters: params, success: { (task:NSURLSessionDataTask, reponse:AnyObject?) in
            print("success")
            completion(error: nil)
        }) { (task:NSURLSessionDataTask?, err:NSError) in
            print("error")
            completion(error: err)
        }
        
    }
}
