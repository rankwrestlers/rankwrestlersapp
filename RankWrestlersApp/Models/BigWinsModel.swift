//
//  BigWinsModel.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/21/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation

protocol BigWinsModelDelegate {
    
    func ItemsDownloaded(bigWins:[BigWin])
    
}

class BigWinsModel: NSObject {
    
    var delegate:BigWinsModelDelegate?
    
    func getItems(_ rankstate:String) {
        
        let serviceURL = "https://RankWrestlers.com/bigwinsapp.php?rankstate=" + rankstate
        
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
        
        var bigWinArray = [BigWin]()
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            for jsonResult in jsonArray{
                
                let jsonDict = jsonResult as! [String:String]
                
                let bigWin = BigWin(wrestler: jsonDict["wrestler"]!, wrestlername: jsonDict["wrestlername"]!, winner: jsonDict["winner"]!, loser: jsonDict["loser"]!, Result: jsonDict["Result"]!, thisclass: jsonDict["class"]!, oppclass: jsonDict["oppclass"]!, myrank: jsonDict["myrank"]!, opprank: jsonDict["opprank"]!, matchdate: jsonDict["matchdate"]!, matchresult: jsonDict["matchresult"]!, winningschool: jsonDict["winningschool"]!, losingschool: jsonDict["losingschool"]!, weight: jsonDict["weight"]!, venue: jsonDict["venue"]!, Opponent: jsonDict["Opponent"]!, winningstate: jsonDict["winningstate"]!, losingstate: jsonDict["losingstate"]!, AdjPerc: jsonDict["AdjPerc"]!)
                print (bigWin)
                bigWinArray.append(bigWin)
            }
            
            DispatchQueue.main.async {
                // Pass the location array back to delegate
                self.delegate?.ItemsDownloaded(bigWins: bigWinArray)
                
            }
            
            
        } catch {
            print("There was an error")
        }
    }
    
}
