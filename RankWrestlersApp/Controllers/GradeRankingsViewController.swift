//
//  GradeRankingsViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/20/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class GradeRankingsViewController: UIViewController,GradeRankingsModelDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var gradeRankingsViewController: UITableView!
    @IBOutlet weak var gradeLabel: UILabel!
    var grade: String? = ""
    var rankstate: String? = ""
    var thisGrade: String? = ""

        var gradeRankingsModel = GradeRankingsModel()
        
        var gradeRankings = [GradeRanking]()

        override func viewDidLoad() {
            super.viewDidLoad()

            gradeLabel.text = grade! + " Rankings"
            switch grade {
            case "Senior":
                thisGrade = "Sr"
            case "Junior":
                thisGrade = "Jr"
            case "Sophomore":
                thisGrade = "So"
            case "Freshman":
                thisGrade = "Fr"
            default:
                thisGrade = "Sr"
                
            }
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            numberFormatter.minimumFractionDigits = 1
            numberFormatter.maximumFractionDigits = 1

            gradeRankingsViewController.delegate = self
            gradeRankingsViewController.dataSource = self
            gradeRankingsViewController.estimatedRowHeight = 20
            gradeRankingsViewController.rowHeight = UITableView.automaticDimension
            
            gradeRankingsModel.getItems(rankstate!,thisGrade!)
            gradeRankingsModel.delegate = self
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
            gradeLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)


        }
        
        func ItemsDownloaded(gradeRankings: [GradeRanking]) {
            self.gradeRankings = gradeRankings
            gradeRankingsViewController.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return gradeRankings.count
        
        }

        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gradeRankingsCell", for: indexPath)
            let num = Double(gradeRankings[indexPath.row].Combo) ?? 0
            
            var thisScore: String = ""
            
            if num > 0 {
                thisScore = String(round(Double(gradeRankings[indexPath.row].Combo)!*1000)/10)
            } else {
                thisScore = "0"
            }
            cell.textLabel?.text = "#" + String(indexPath.row + 1) + " - " + gradeRankings[indexPath.row].wrestlername + " (" + gradeRankings[indexPath.row].school + "): " + thisScore + "%"
            return cell
        }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
       if segue.identifier != "gradeRankingsMenu" {

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
           }
         
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
        var rankToSend: String = ""
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            textToSend = gradeRankings[indexPath.row].wrestler
            wrestlerNameToSend = gradeRankings[indexPath.row].wrestlername
            schoolNameToSend = gradeRankings[indexPath.row].school
            gradeToSend = gradeRankings[indexPath.row].grade
            weightClassToSend = gradeRankings[indexPath.row].rankweight
            winsToSend = gradeRankings[indexPath.row].Wins
            lossesToSend = gradeRankings[indexPath.row].Losses
            totalScoreToSend = gradeRankings[indexPath.row].Combo
            adjPercToSend = gradeRankings[indexPath.row].AdjPerc
            threeBestToSend = gradeRankings[indexPath.row].ThreeBest
            h2hToSend = gradeRankings[indexPath.row].H2H
            rankToSend = gradeRankings[indexPath.row].rank
            
            self.performSegue(withIdentifier: "gradeProfile", sender: self)
            
        }

    }
