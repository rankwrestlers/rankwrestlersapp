//
//  RostersModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/14/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

protocol RostersModelDelegate {
    
    func ItemsDownloaded(rosters:[Roster])
    
}

class RostersModel: NSObject {
    
    var delegate:RostersModelDelegate?
    
    func getItems(_ rankstate:String, _ school:String) {
        
        let thisSchool = school.replacingOccurrences(of: " ", with: "%20")
        
        let serviceURL = "https://RankWrestlers.com/rostersapp.php?rankState=" + rankstate + "&school=" + thisSchool
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
            
            var rostersArray = [Roster]()
            
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                
                for jsonResult in jsonArray{
                    
                    let jsonDict = jsonResult as! [String:String]
                    
                    let roster = Roster(wrestler: jsonDict["wrestler"]!, wrestlername: jsonDict["wrestlername"]!, school: jsonDict["school"]!, grade: jsonDict["grade"]!, rankweight: jsonDict["rankweight"]!, Wins: jsonDict["Wins"]!, Losses: jsonDict["Losses"]!, Combo: jsonDict["Combo"]!, AdjPerc:jsonDict["AdjPerc"]!, ThreeBest:jsonDict["ThreeBest"]!, H2H: jsonDict["H2H"]!, rank: jsonDict["rank"]!)
                    print (roster)
                    rostersArray.append(roster)
                }
                
                DispatchQueue.main.async {
                    // Pass the location array back to delegate
                    self.delegate?.ItemsDownloaded(rosters: rostersArray)
                    
                }
                
                
            } catch {
                print("There was an error")
            }
        }
        
    }
