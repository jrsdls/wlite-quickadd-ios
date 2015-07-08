//
//  MainVC.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 6/16/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var listButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.headerView.backgroundColor = UIColor.appMainColor()
//        self.navigationController!.navigationBar.barTintColor = UIColor.appMainColor()
        self.view.tintColor = UIColor.appDarkMainColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.appDarkMainColor()]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        println("MainVC.isAuthenticated " + (isAuthenticated() ? "yes" : "no"))
        if (!isAuthenticated()) {
            performSegueWithIdentifier("showAuthVC", sender: self)
        }else {
            if textField.canBecomeFirstResponder() {
                textField.becomeFirstResponder()
            }
            listButton.setTitle("A very very very long list title", forState: .Normal)
        }
        
        // some tests
//        self.readUser()
//        self.readFolders()
//        self.readFolderRevisions()
//        self.readFolder("946735")
//        self.readLists()
//        self.createList("Bucket")
//        self.readList("86173208")
//        self.createTask("Test task, hola mundo!", forList: 164291775);
//        self.readTasks("86173208")

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
    
    // MARK: - Convenience Methods
    
    private func isAuthenticated() -> Bool{
        // TODO: build new common framework release with latest code and use Wlite.isAuthenticated()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.stringForKey("com.wlite.oauth.accessToken") != nil
    }

}
