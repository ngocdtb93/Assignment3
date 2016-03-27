//
//  PostViewController.swift
//  Assignment3
//
//  Created by Ngoc Do on 3/27/16.
//  Copyright © 2016 com.appable. All rights reserved.
//

import UIKit
import Social

class PostViewController: UIViewController {
    

    @IBAction func btnBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnTweet(sender: AnyObject) {
        
        TwitterClient.shareInstance.postTweet(txtContent.text, success: { () in
            print("sucees")
            self.navigationController?.popViewControllerAnimated(true)
        }) { (err:NSError) in
                print("erorr:")
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var txtContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        txtContent.becomeFirstResponder()
    }

   
    func loadData(){
        self.view.showLoading()
        avatar.setImageWithURL(User.currentUser!.profileURL!)
        
        lblName.text = User.currentUser!.name
        
        lblLocation.text = User.currentUser!.location
        self.view.hideLoading()
    }
   
}
extension PostViewController:UITextViewDelegate{
    func textViewDidChange(textView: UITextView) {
        lblCount.text = String(textView.text.characters.count)
        if( txtContent.text.characters.count > 200 ){
            textView.text = String(textView.text.characters.dropLast())
        }
    }
}

