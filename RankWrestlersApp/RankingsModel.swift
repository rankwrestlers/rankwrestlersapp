//
//  RankingsModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/14/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

protocol RankingsModelDelegate {
    
    func ItemsDownloaded(rankings:[Ranking])
    
}

class RankingsModel: NSObject {
    
    var delegate:RankingsModelDelegate?
    
    func getItems(_ rankclass:String, _ rankstate:String, _ rankweight:String) {
        
        let serviceURL = "https://RankWrestlers.com/rankingsapp.php?rankClass=" + rankclass + "&rankWeight=" + rankweight + "&rankState=" + rankstate
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
        
        var rankArray = [Ranking]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let ranking = Ranking(wrestler: jsonDict["wrestler"]!, wrestlername: jsonDict["wrestlername"]!, school: jsonDict["school"]!, grade: jsonDict["grade"]!, rankweight: jsonDict["rankweight"]!,Wins: jsonDict["Wins"]!,Losses: jsonDict["Losses"]!, Combo: jsonDict["Combo"]!, AdjPerc:jsonDict["AdjPerc"]!, ThreeBest:jsonDict["ThreeBest"]!, H2H: jsonDict["H2H"]!, rank: jsonDict["rank"]!)
                    print(ranking)
                    rankArray.append(ranking)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(rankings: rankArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
