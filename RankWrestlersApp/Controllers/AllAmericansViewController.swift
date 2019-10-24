//
//  AllAmericansViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/22/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class AllAmericansViewController: UIViewController,AllAmericansModelDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var allAmericanLabel: UILabel!
    @IBOutlet weak var allAmericansViewController: UITableView!

        var rankstate:String? = ""
     
        var allAmericansModel = AllAmericansModel()
        
        var allAmericans = [AllAmerican]()

        override func viewDidLoad() {
            super.viewDidLoad()
            rankstate = stateName.thisState

            allAmericanLabel.text = rankstate! + " All-Americans"
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            numberFormatter.minimumFractionDigits = 1
            numberFormatter.maximumFractionDigits = 1

            allAmericansViewController.delegate = self
            allAmericansViewController.dataSource = self
            allAmericansViewController.estimatedRowHeight = 20
            allAmericansViewController.rowHeight = UITableView.automaticDimension
            
            allAmericansModel.getItems(rankstate!)
            allAmericansModel.delegate = self
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
            allAmericanLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)


        }
        
        func ItemsDownloaded(allAmericans: [AllAmerican]) {
            self.allAmericans = allAmericans
            allAmericansViewController.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return allAmericans.count
        
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier != "allAmericansMenu" {

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
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "allAmericansCell", for: indexPath)
            let num = Double(allAmericans[indexPath.row].Combo) ?? 0
            
            var thisScore: String = ""
            
            if num > 0 {
                thisScore = String(round(Double(allAmericans[indexPath.row].Combo)!*1000)/10)
            } else {
                thisScore = "0"
            }
            cell.textLabel?.text = allAmericans[indexPath.row].wrestlername + " (" + allAmericans[indexPath.row].grade + ", " + allAmericans[indexPath.row].school + "): " + thisScore + "%"
            cell.textLabel?.numberOfLines = 0
            return cell
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
            textToSend = allAmericans[indexPath.row].wrestler
            wrestlerNameToSend = allAmericans[indexPath.row].wrestlername
            schoolNameToSend = allAmericans[indexPath.row].school
            gradeToSend = allAmericans[indexPath.row].grade
            weightClassToSend = allAmericans[indexPath.row].rankweight
            winsToSend = allAmericans[indexPath.row].Wins
            lossesToSend = allAmericans[indexPath.row].Losses
            totalScoreToSend = allAmericans[indexPath.row].Combo
            adjPercToSend = allAmericans[indexPath.row].AdjPerc
            threeBestToSend = allAmericans[indexPath.row].ThreeBest
            h2hToSend = allAmericans[indexPath.row].H2H
            rankToSend = allAmericans[indexPath.row].rank
            
            self.performSegue(withIdentifier: "allAmericansProfile", sender: self)
            
        }

    }
