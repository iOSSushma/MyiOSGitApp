//
//  Sample.swift
//  MyGitProject
//
//  Created by Raja Pratap Singh on 31/01/16.
//  Copyright © 2016 XYZ India Pvt Ltd. All rights reserved.
//

import UIKit

class Sample: NSObject {
    
    func abc() {
        
        // MARK: Using NSURLSession
        
        // Get first post
        let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
        guard let url = NSURL(string: postEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on /posts/1")
                print(error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            let post: NSDictionary
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            // now we have the post, let's just print it to prove we can access it
            print("The post is: " + post.description)
            
            // the post object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
            if let postTitle = post["title"] as? String {
                print("The title is: " + postTitle)
            }
        })
        task.resume()
        
        // Create new post
        let postsEndpoint: String = "http://jsonplaceholder.typicode.com/posts"
        guard let postsURL = NSURL(string: postsEndpoint) else {
            print("Error: cannot create URL")
           
            return
        }
        
        let postsUrlRequest = NSMutableURLRequest(URL: postsURL)
        
        postsUrlRequest.HTTPMethod = "POST"
        
        let newPost: NSDictionary = ["title": "Frist Psot", "body": "I iz fisrt", "userId": 1]
        do {
            let jsonPost = try NSJSONSerialization.dataWithJSONObject(newPost, options: [])
            postsUrlRequest.HTTPBody = jsonPost
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            let createTask = session.dataTaskWithRequest(postsUrlRequest, completionHandler: {
                (data, response, error) in
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                guard error == nil else {
                    print("error calling GET on /posts/1")
                    print(error)
                    return
                }
                
                // parse the result as json, since that's what the API provides
                
                do {
                    let post = try NSJSONSerialization.JSONObjectWithData(responseData, options: [])
                    
                    print(post)
                    
                    if let postID = post["id"] {
                        print("The post ID is \(postID)")
                    }

                }
                    
                catch {
                    print("Exception")
                }

                            })
            createTask.resume()
        } catch {
            print("Error: cannot create JSON from post")
        }
        
        // Delete first post
        let firstPostEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
        let firstPostUrlRequest = NSMutableURLRequest(URL: NSURL(string: firstPostEndpoint)!)
        firstPostUrlRequest.HTTPMethod = "DELETE"
        
        let deleteTask = session.dataTaskWithRequest(firstPostUrlRequest, completionHandler: {
            (data, response, error) in
            guard let _ = data else {
                print("error calling DELETE on /posts/1")
                return
            }
        })
        deleteTask.resume()
    
    }

}
