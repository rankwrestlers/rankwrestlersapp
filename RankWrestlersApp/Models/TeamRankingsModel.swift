//
//  TeamRankingsModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/15/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

protocol TeamRankingsModelDelegate {
    
    func ItemsDownloaded(teamRankings:[TeamRanking])
    
}

class TeamRankingsModel: NSObject {
    
    var delegate:TeamRankingsModelDelegate?
    
    func getItems(_ rankstate:String, _ rankclass:String) {
        
        let serviceURL = "https://RankWrestlers.com/teamrankingsapp.php?rankState=" + rankstate + "&rankClass=" + rankclass
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
        
        var teamRankingsArray = [TeamRanking]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let teamRanking = TeamRanking(rankclass: jsonDict["class"]!, school: jsonDict["school"]!,total: jsonDict["Total"]!,first: jsonDict["1.0"]!,second: jsonDict["2.0"]!,third: jsonDict["3.0"]!,fourth: jsonDict["4.0"]!,fifth: jsonDict["5.0"]!,sixth: jsonDict["6.0"]!,seventh: jsonDict["7.0"]!,eighth: jsonDict["8.0"]!)
                
                    print(teamRanking)
                    teamRankingsArray.append(teamRanking)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(teamRankings: teamRankingsArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
