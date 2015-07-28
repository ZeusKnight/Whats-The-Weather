//
//  ViewController.swift
//  Whats The Weather
//
//  Created by mocha on 7/27/15.
//  Copyright (c) 2015 mocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cityInput: UITextField!
    
    @IBAction func buttonClick(sender: AnyObject) {
        var URL = NSURL(string: "http://www.weather-forecast.com/locations/" + cityInput.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest");
        var newWeather = "";
        if(URL != nil) {
            let task = NSURLSession.sharedSession().dataTaskWithURL(URL!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false;
                
                if(error == nil) {
                    var htmlString = NSString(data: data, encoding: NSUTF8StringEncoding);
                    
                    println(htmlString);
                    
                    var weather = htmlString?.componentsSeparatedByString("<span class=\"phrase\">") as! [String];
                    
                    if(weather.count > 1) {
                        var weatherArray = weather[1].componentsSeparatedByString("</span>");
                        newWeather = weatherArray[0] as String;
                        newWeather = newWeather.stringByReplacingOccurrencesOfString("&deg;", withString: "°");
                    } else {
                        urlError = true;
                    }
                } else {
                    urlError = true;
                }
                dispatch_async(dispatch_get_main_queue()) {
                    if(urlError == true) {
                        self.resultOtput.text = "Was not able to find weather for " + self.cityInput.text + ". Please try again";
                    } else {
                        self.resultOtput.text = newWeather;
                    }
                }
                
            });
            
            task.resume();
            
        } else {
            resultOtput.text = "Was not able to find weather for " + cityInput.text + ". Please try again";
        }
    }
    @IBOutlet var resultOtput: UILabel!
    
    @IBOutlet var resultOutput: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

