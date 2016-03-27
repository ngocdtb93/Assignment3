//
//  User.swift
//  Assignment3
//
//  Created by Ngoc Do on 3/27/16.
//  Copyright © 2016 com.appable. All rights reserved.
//

import UIKit

class User: NSObject {
    var name:String?
    var screenName:String?
    var profileURL:NSURL?
    var tagline:String?
    var location:String?
    
    var dict:NSDictionary?
    
    init(dict:NSDictionary) {
        self.dict = dict
        name = dict["name"] as? String
        screenName = dict["screen_name"] as? String
        tagline = dict["description"] as? String
        let url = dict["profile_image_url_https"] as? String
        if let url = url{
            profileURL = NSURL(string: url)
        }
        let loc = dict["location"] as?String
        if let loc = loc{
            location = loc
        }
    }
    static var _currentUser:User?
    
    class var currentUser:User?{
        get{
            if(_currentUser == nil){
                 let userData = userDefault.objectForKey("currentUser") as? NSData
                if let userData = userData {
                    let dict:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dict: dict)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            if let user = user{
                
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dict!, options: [])
                userDefault.setObject(data, forKey: "currentUser")
            }else{
                userDefault.setObject(nil, forKey: "currentUser")
                
            }
            userDefault.synchronize()
            
        }
    }

}


