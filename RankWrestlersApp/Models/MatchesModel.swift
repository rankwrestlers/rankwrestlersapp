//
//  MatchesModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 9/2/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation

protocol MatchesModelDelegate {
    
    func ItemsDownloaded(matches:[Match])
    
}

class MatchesModel: NSObject {
    
    var delegate:MatchesModelDelegate?
    
    func getItems(_ rankstate:String,_ wrestlerId:String) {
        
        let serviceURL = "https://RankWrestlers.com/wrestlerresultsapp.php?wrestler=" + wrestlerId + "&rankstate=" + rankstate
        
        print ("serviceURL: " + serviceURL)
        
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
        
        var locArray = [Match]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let loc = Match(wrestler: jsonDict["wrestler"]!, wrestlername: jsonDict["wrestlername"]!, winner: jsonDict["winner"]!, loser: jsonDict["loser"]!, Result: jsonDict["Result"]!, matchdate: jsonDict["matchdate"]!, matchresult: jsonDict["matchresult"]!, winningschool: jsonDict["winningschool"]!, losingschool: jsonDict["losingschool"]!, weight: jsonDict["weight"]!, venue: jsonDict["venue"]!, Opponent: jsonDict["Opponent"]!, winningstate: jsonDict["winningstate"]!, losingstate: jsonDict["losingstate"]!, AdjPerc: jsonDict["AdjPerc"]!)
                print (loc)
                locArray.append(loc)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(matches: locArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
