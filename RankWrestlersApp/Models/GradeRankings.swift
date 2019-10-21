//
//  GradeRankings.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/20/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

protocol GradeRankingsModelDelegate {
    
    func ItemsDownloaded(gradeRankings:[GradeRanking])
    
}

class GradeRankingsModel: NSObject {
    
    var delegate:GradeRankingsModelDelegate?
    
    func getItems(_ rankstate:String, _ grade:String) {
        
        let serviceURL = "https://RankWrestlers.com/graderankingsapp.php?rankState=" + rankstate + "&grade=" + grade
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
        
        var rankArray = [GradeRanking]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let ranking = GradeRanking(wrestler: jsonDict["wrestler"]!, wrestlername: jsonDict["wrestlername"]!, school: jsonDict["school"]!, grade: jsonDict["grade"]!, rankweight: jsonDict["rankweight"]!,Wins: jsonDict["Wins"]!,Losses: jsonDict["Losses"]!, Combo: jsonDict["Combo"]!, AdjPerc:jsonDict["AdjPerc"]!, ThreeBest:jsonDict["ThreeBest"]!, H2H: jsonDict["H2H"]!)
                    print(ranking)
                    rankArray.append(ranking)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(gradeRankings: rankArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
