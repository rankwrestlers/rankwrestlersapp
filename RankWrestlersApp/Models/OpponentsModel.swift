//
//  OpponentsModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/16/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

protocol OpponentsModelDelegate {
    
    func ItemsDownloaded(opponents:[Opponent])
    
}

class OpponentsModel: NSObject {
    
    var delegate:OpponentsModelDelegate?
    
    func getItems(_ rankstate:String, _ opponent:String) {
        
        let serviceURL = "https://RankWrestlers.com/opponentsapp.php?rankstate=" + rankstate + "&opponent=" + opponent
        
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
        
        var opponentArray = [Opponent]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let opp = Opponent(wrestler: jsonDict["wrestler"]!, wrestlername: jsonDict["wrestlername"]!, school: jsonDict["school"]!, grade: jsonDict["grade"]!, rankweight: jsonDict["rankweight"]!, Wins: jsonDict["Wins"]!, Losses: jsonDict["Losses"]!, Combo: jsonDict["Combo"]!, AdjPerc:jsonDict["AdjPerc"]!, ThreeBest:jsonDict["ThreeBest"]!, H2H: jsonDict["H2H"]!, rank: jsonDict["rank"]!)
                print(opp)
                opponentArray.append(opp)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(opponents: opponentArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
