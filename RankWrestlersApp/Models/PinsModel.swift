//
//  PinsModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/21/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

protocol PinsModelDelegate {
    
    func ItemsDownloaded(pins:[Pin])
    
}

class PinsModel: NSObject {
    
    var delegate:PinsModelDelegate?
    
    func getItems(_ rankstate:String) {
        
        let serviceURL = "https://RankWrestlers.com/pinrankingsapp.php?rankstate=" + rankstate
        
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
        
        var pinArray = [Pin]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let pins = Pin(wrestler: jsonDict["wrestler"]!, wrestlername: jsonDict["wrestlername"]!, school: jsonDict["school"]!, grade: jsonDict["grade"]!, rankweight: jsonDict["rankweight"]!, Wins: jsonDict["Wins"]!, Losses: jsonDict["Losses"]!, Combo: jsonDict["Combo"]!, AdjPerc:jsonDict["AdjPerc"]!, ThreeBest:jsonDict["ThreeBest"]!, H2H: jsonDict["H2H"]!, rank: jsonDict["rank"]!, pintotal: jsonDict["pintotal"]!, pinperc: jsonDict["pinperc"]!)
                print(pins)
                pinArray.append(pins)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(pins: pinArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
