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

    @IBOutlet weak var teamRankingsMenu: UIBarButtonItem!

    var rankclass:String? = ""
       var rankstate:String? = ""
   
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
               let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))

               let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
               imageView.contentMode = .scaleAspectFit
               let image = UIImage(named: "rwlogo")
               imageView.image = image
               imageView.tintColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
                logoContainer.addSubview(imageView)
               navigationItem.titleView = logoContainer
                navigationController?.navigationBar.barTintColor = UIColor.black
                tabBarController?.tabBar.barTintColor = UIColor.black
               tabBarController?.tabBar.tintColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
            teamRankingsLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)

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
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if segue.identifier != "teamRankingsMenu" {

           let info = segue.destination as! RostersViewController
           info.school = schoolToSend
           info.rankstate = rankstateToSend
        }
        }
        
        var schoolToSend: String = ""
        var rankstateToSend: String = ""
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            schoolToSend = teamRankings[indexPath.row].school
            rankstateToSend = rankstate!
            
            self.performSegue(withIdentifier: "teamRankingRoster", sender: self)
            
        }
     
    }
