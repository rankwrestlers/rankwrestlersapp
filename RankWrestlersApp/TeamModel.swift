//
//  TeamModel.swift
//  TeamsViewApp
//
//  Created by RankWresters on 9/4/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

protocol TeamModelDelegate {
    
    func itemsDownloaded(teams:[Team])
    
}

class TeamModel: NSObject {
    
    var delegate:TeamModelDelegate?
    
    func getItems() {
        
        // Hit the web service url
        
        let rankState = "MO"
        
        let serviceurl = "https://rankwrestlers.com/teamsapp.php?state=" + rankState
        
        // Download the json data
        
        let url = URL(string: serviceurl)
        
        if let url = url {
            
            //Creat a URL session
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url,completionHandler:  { (data, response, error) in
                
                if error == nil {
                    
                    //succeeded
                    //Call the parse json function on the data
                    
                    self.parseJson(data: data!)
                    
                } else {
                    
                    //error occured
                    
                }
                
            })
            
            task.resume()
            
        }
    }
    
    
    func parseJson(data: Data) {
        
        var teamArray = [Team]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                
                let team = Team(school: jsonDict["school"]!, thisclass: jsonDict["class"]!)
                
                teamArray.append(team)
                
                
                
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.itemsDownloaded(teams: teamArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
        
        
    }
    
    
}
