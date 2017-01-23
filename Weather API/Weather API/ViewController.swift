//
//  ViewController.swift
//  Weather API
//
//  Created by Zachary Cheshire on 1/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBAction func submit(_ sender: Any) {
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + textLabel.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=08e64df2d3f3bc0822de1f0fc22fcb2d") {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in // URLSession.shared().dataTask(with: url) { (data, response, error) is now URLSession.shared.dataTask(with: url) { (data, response, error)
                
                if error != nil {
                    
                    print(error)
                    
                } else {
                    
                    if let urlContent = data {
                        
                        do {
                            
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject // Added "as anyObject" to fix syntax error in Xcode 8 Beta 6
                            
                            print(jsonResult)
                            
                            print(jsonResult["name"])
                                if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                
                                    DispatchQueue.main.sync(execute: {
                                    
                                    self.label.text = description
                                    
                                    })
                                
                                }
                            
                            
                        } catch {
                            
                            print("JSON Processing Failed")
                            
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            task.resume()
            
        } else {
            
            print("Couldn't find weather for that city - please try another.")
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

