//
//  ViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 9/1/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var homeModel = HomeModel()
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        homeModel.getItems()
        homeModel.delegate = self
       
    }

    func ItemsDownloaded(locations: [Location]) {
        self.locations = locations
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let info = segue.destination as! ProfileViewController
        info.myString = textToSend
        info.wrestlerName = wrestlerNameToSend
        info.schoolName = schoolNameToSend
        info.grade = gradeToSend
        info.totalScore = totalScoreToSend
        info.adjPerc = adjPercToSend
        info.H2H = h2hToSend
        info.top3 = threeBestToSend
        info.Wins = winsToSend
        info.Losses = lossesToSend
        info.weightClass = weightClassToSend + " lbs"
        
     }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell", for: indexPath)
        
        let totalScore = round(Double(locations[indexPath.row].Combo)!*1000)/10
        
        cell.textLabel?.text = locations[indexPath.row].rankweight + " - " + locations[indexPath.row].wrestlername + " (" + locations[indexPath.row].Wins + "-" + locations[indexPath.row].Losses + "): " + String(totalScore) + "% (" + locations[indexPath.row].grade + ")"
        
        return cell
        
    }
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Wrestlers Following"
    }
    
    var textToSend: String = ""
    var wrestlerNameToSend: String = ""
    var schoolNameToSend: String = ""
    var weightClassToSend: String = ""
    var winsToSend: String = ""
    var lossesToSend: String = ""
    var totalScoreToSend: String = ""
    var adjPercToSend: String = ""
    var h2hToSend: String = ""
    var threeBestToSend: String = ""
    var gradeToSend: String = ""
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textToSend = locations[indexPath.row].wrestler
        wrestlerNameToSend = locations[indexPath.row].wrestlername
        schoolNameToSend = locations[indexPath.row].school
        gradeToSend = locations[indexPath.row].grade
        weightClassToSend = locations[indexPath.row].rankweight
        winsToSend = locations[indexPath.row].Wins
        lossesToSend = locations[indexPath.row].Losses
        totalScoreToSend = locations[indexPath.row].Combo
        adjPercToSend = locations[indexPath.row].AdjPerc
        h2hToSend = locations[indexPath.row].H2H
        threeBestToSend = locations[indexPath.row].ThreeBest
        
        self.performSegue(withIdentifier: "GoToMatches", sender: self)
        
    }

}

