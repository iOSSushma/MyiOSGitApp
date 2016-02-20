//
//  LoginViewController.swift
//  MyGitProject
//
//  Created by Sushma on 20/02/16.
//  Copyright © 2016 XYZ India Pvt Ltd. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate {
    
    func loginSuccessful()

}


class LoginViewController: UIViewController {
    
    
    var delegate : LoginViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginStart(sender: AnyObject) {
        
        self.performSelector("credntialsAreCorrect", withObject: nil, afterDelay: 2)
        
    
    }
    
    func credntialsAreCorrect() {
        
        delegate?.loginSuccessful()
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
