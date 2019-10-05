//
//  HomeModel.swift
//  mySQL Demo App
//
//  Created by RankWresters on 8/29/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

protocol HomeModelDelegate {
    
    func ItemsDownloaded(locations:[Location])
    
}

class HomeModel: NSObject {
    
    var delegate:HomeModelDelegate?
    
    func getItems() {
        
        let serviceURL = "https://RankWrestlers.com/followingapp.php"
        
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
        
        var locArray = [Location]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let loc = Location(wrestler: jsonDict["wrestler"]!, wrestlername: jsonDict["wrestlername"]!, school: jsonDict["school"]!, grade: jsonDict["grade"]!, rankweight: jsonDict["rankweight"]!, Wins: jsonDict["Wins"]!, Losses: jsonDict["Losses"]!, Combo: jsonDict["Combo"]!, rank: jsonDict["rank"]!)
                locArray.append(loc)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(locations: locArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
