//
//  AuthenticationController.swift
//  MyGitProject
//
//  Created by Sushma on 20/02/16.
//  Copyright © 2016 XYZ India Pvt Ltd. All rights reserved.
//

import UIKit


extension UIViewController {
    var authenticationController: AuthenticationController? {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).authenticationController
    }
}


class AuthenticationController: UIViewController, LoginViewControllerDelegate {
    
    // MARK: - Private Varibale
    private var loginViewController: LoginViewController!
    private var mainViewController: MainTabViewController!
    

    override func viewDidLoad() {
        
        //self.view.backgroundColor = UIColor.redColor()
        
        self.loadLoginController()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadLoginController() {
        
        // create the login controller
        self.loginViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
        
        self.loginViewController.delegate = self

        // add login as child view controller
        self.addChildViewController(loginViewController)
        view.addSubview(loginViewController.view)
        loginViewController.didMoveToParentViewController(self)
        
    }

    
    func loginSuccessful() {
        
        
        // create the root view controller
        self.mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTabViewController") as? MainTabViewController
        
        // perform any additional service request or just load the main view controller
        transitionFromViewController(self.loginViewController, toController: self.mainViewController, options: UIViewAnimationOptions.TransitionCrossDissolve)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appTimeOutFuctionCall:", name: "IDEAL_TIMER_EXCEED_NOTIFICATION", object:nil)

        
        print("loginSuccessful")
    }
    
    // MARK: - Instance Method
    func signOut() {
        
        flipFromViewController(mainViewController, toController: loginViewController, options: UIViewAnimationOptions.TransitionNone)
        self.mainViewController = nil
        
    }
    
    // to controller is the split view controller
    private func transitionFromViewController(fromController: UIViewController, toController: UIViewController, options: UIViewAnimationOptions) {
        
        toController.view.frame = fromController.view.bounds
        self.addChildViewController(toController)
        fromController.willMoveToParentViewController(nil)
        
        self.view.addSubview(toController.view)
        
        UIView.transitionFromView(fromController.view, toView: toController.view, duration: 1.0, options: options, completion: { (finished) -> Void in
            toController.didMoveToParentViewController(self)
            
            fromController.removeFromParentViewController()
            fromController.view.removeFromSuperview()
        })
    }
    
    /**
     Make the transition from Login to next controller with TransitionCrossDissolve animation
     
     :param: fromController - current controller, toController - next controller, options - Animation type
     */
    func flipFromViewController(fromController: UIViewController, toController: UIViewController, options: UIViewAnimationOptions) {
        toController.view.frame = fromController.view.bounds
        self.addChildViewController(toController)
        fromController.willMoveToParentViewController(nil)
        
        self.transitionFromViewController(fromController, toViewController: toController, duration: 0.2, options: options, animations: {}) { (finished) -> Void in
            fromController.removeFromParentViewController()
            toController.didMoveToParentViewController(self)
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
