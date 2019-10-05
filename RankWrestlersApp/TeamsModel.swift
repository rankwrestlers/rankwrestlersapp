//
//  HomeModel.swift
//  mySQL Demo App
//
//  Created by RankWresters on 8/29/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

protocol TeamsModelDelegate {
    
    func ItemsDownloaded(teams:[Team])
    
}

class TeamsModel: NSObject {
    
    var delegate:TeamsModelDelegate?
    
    var rankState: String = ""
    
    func getItems() {
        
        let serviceURL = "https://RankWrestlers.com/teams.php"
        
        let url = URL(string: serviceURL)
        
        if let url = url {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler:  { (data, response, error) in
                
                if error == nil {
                    
                    self.parseJson(data: data!)
                    
                } else {
                    
                }
                
            })
            
            // Start the task
            task.resume()
            
        }
        
    }
    
    func parseJson(data:Data) {
        
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
                self.delegate?.ItemsDownloaded(teams: teamArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
