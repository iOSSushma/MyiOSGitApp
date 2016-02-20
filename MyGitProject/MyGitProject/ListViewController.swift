//
//  ListViewController.swift
//  MyGitProject
//
//  Created by Sushma on 20/02/16.
//  Copyright © 2016 XYZ India Pvt Ltd. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var openOrderList : [Order] = []
    
    var closeOrderList : [Order] = []
    
    
    @IBOutlet weak var orderTableView: UITableView!
    
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderTableView.delegate = self
        orderTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutfromListView(sender: AnyObject) {
        
        authenticationController?.signOut()
    }

    func getOrderList() {
        
        let jsonDataArray : [NSDictionary] = self.parseOrderData()
        
        
        
        
    }
    
    func parseOrderData() -> [NSDictionary]{
        
        let filepath = NSBundle.mainBundle().pathForResource("orderslist", ofType: "json")
        
    let fileData = NSData(contentsOfFile: filepath!)
        
        var jsonObjects : AnyObject? = nil
        
        do {
            
            jsonObjects = try NSJSONSerialization.JSONObjectWithData(fileData!, options:.AllowFragments)
            
            print(jsonObjects)
            
        }
            
        catch
        {
            print("Exceptions")
            
            
        }
        
        let jsonArray: [NSDictionary] = ( jsonObjects as? [NSDictionary])!
        
        return jsonArray
    
    
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
     return 1
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    
    
    }
    



}
