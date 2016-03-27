//
//  LoginViewController.swift
//  Assignment3
//
//  Created by Ngoc Do on 3/27/16.
//  Copyright © 2016 com.appable. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    @IBAction func btnLogIn(sender: AnyObject) {
        TwitterClient.shareInstance.login({
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }) { (err:NSError) in
                print(err.localizedDescription)
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
