//
//  TeamRankingsViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/14/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class TeamRankingsViewController: UIViewController,TeamRankingsModelDelegate,UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var teamRankingsLabel: UILabel!
    
    @IBOutlet weak var teamRankingsViewController: UITableView!

       var rankclass:String? = ""
       var rankstate:String? = ""
       var rankweight:String? = ""
       var weight:String? = ""
       var classname:String? = ""
       var wrestler:String? = ""
       var wrestlername:String? = ""
       var school:String? = ""
       var grade:String? = ""
       var Wins:String? = ""
       var Losses:String? = ""
       var Combo:String? = ""
       var AdjPerc:String? = ""
       var ThreeBest:String? = ""
       var H2H:String? = ""
       var rank:String? = ""
    
       var teamRankingsModel = TeamRankingsModel()
       
       var teamRankings = [TeamRanking]()

       override func viewDidLoad() {
           super.viewDidLoad()

           teamRankingsLabel.text = "Class " + rankclass! + " Team Rankings"
           let numberFormatter = NumberFormatter()
           numberFormatter.numberStyle = .percent
           numberFormatter.minimumFractionDigits = 1
           numberFormatter.maximumFractionDigits = 1

           teamRankingsViewController.delegate = self
           teamRankingsViewController.dataSource = self
           teamRankingsViewController.estimatedRowHeight = 20
           teamRankingsViewController.rowHeight = UITableView.automaticDimension
           
           teamRankingsModel.getItems(rankstate!,rankclass!)
           teamRankingsModel.delegate = self
           // Do any additional setup after loading the view.
       }

      func ItemsDownloaded(teamRankings: [TeamRanking]) {
        self.teamRankings = teamRankings
        teamRankingsViewController.reloadData()
       }
           
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return teamRankings.count
       
       }

/*       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
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
         info.rank = rankToSend
         
      } */
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    
        var previousscore = ""
        var thisrank = ""
        var previousrank = ""

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "teamRankCell", for: indexPath)
        let thisscore = teamRankings[indexPath.row].total
        if thisscore == previousscore {
            thisrank = previousrank
        } else {
            thisrank = String(indexPath.row + 1)
        }
        cell.textLabel?.text = "#" + thisrank + " - " + teamRankings[indexPath.row].school + ", " + thisscore + " points"
            previousscore = thisscore
            previousrank = thisrank
           return cell
       }
}
