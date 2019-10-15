//
//  TeamClassesModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/14/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

protocol TeamClassesModelDelegate {
    
    func ItemsDownloaded(teamClasses:[TeamClass])
    
}

class TeamClassesModel: NSObject {
    
    var delegate:TeamClassesModelDelegate?
    
    func getItems(_ rankstate:String) {
        
        let serviceURL = "https://RankWrestlers.com/teamclassesapp.php?rankState=" + rankstate
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
        
        var teamClassesArray = [TeamClass]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let teamClass = TeamClass(rankclass: jsonDict["class"]!)
                
                    print(teamClass)
                    teamClassesArray.append(teamClass)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(teamClasses: teamClassesArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
