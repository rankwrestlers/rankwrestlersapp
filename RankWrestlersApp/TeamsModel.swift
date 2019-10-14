//
//  TeamsModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/14/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation

import UIKit

protocol TeamsModelDelegate {
    
    func ItemsDownloaded(teams:[Team])
    
}

class TeamsModel: NSObject {
    
    var delegate:TeamsModelDelegate?
    
    func getItems(_ rankstate:String) {
        
        let serviceURL = "https://RankWrestlers.com/teamsapp.php?rankState=" + rankstate
        print (serviceURL)
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
                
                let team = Team(school: jsonDict["school"]!, rankclass: jsonDict["class"]!)
                
                    print(team)
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
