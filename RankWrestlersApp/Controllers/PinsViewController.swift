//
//  PinsViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/21/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class PinsViewController: UIViewController,PinsModelDelegate, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var pinsLabel: UILabel!
    @IBOutlet weak var pinsViewController: UITableView!
 
    var rankstate: String? = ""
    var rankweight:String? = ""
    var weight:String? = ""
    var classname:String? = ""
    var rankclass:String? = ""
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
    var state:String? = ""

        var pinsModel = PinsModel()
        
        var pins = [Pin]()

        override func viewDidLoad() {
            super.viewDidLoad()

            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            numberFormatter.minimumFractionDigits = 1
            numberFormatter.maximumFractionDigits = 1

            pinsViewController.delegate = self
            pinsViewController.dataSource = self
            pinsViewController.estimatedRowHeight = 20
            pinsViewController.rowHeight = UITableView.automaticDimension
            
            pinsModel.getItems(rankstate!)
            pinsModel.delegate = self
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
            pinsLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)


        }
        
        func ItemsDownloaded(pins: [Pin]) {
            self.pins = pins
            pinsViewController.reloadData()
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return pins.count
        
        }

        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

     var previousscore = ""
     var thisrank = ""
     var previousrank = ""

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pinsCell", for: indexPath)
            let thisscore = pins[indexPath.row].pintotal
            if thisscore == previousscore {
                thisrank = previousrank
            } else {
                thisrank = String(indexPath.row + 1)
            }
            cell.textLabel?.text = "#" + thisrank + " - " + pins[indexPath.row].wrestlername + " (" + pins[indexPath.row].school + "): " + pins[indexPath.row].pintotal
            previousscore = thisscore
            previousrank = thisrank
            return cell
        }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
       if segue.identifier != "pinsMenu" {

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
            textToSend = pins[indexPath.row].wrestler
            wrestlerNameToSend = pins[indexPath.row].wrestlername
            schoolNameToSend = pins[indexPath.row].school
            gradeToSend = pins[indexPath.row].grade
            weightClassToSend = pins[indexPath.row].rankweight
            winsToSend = pins[indexPath.row].Wins
            lossesToSend = pins[indexPath.row].Losses
            totalScoreToSend = pins[indexPath.row].Combo
            adjPercToSend = pins[indexPath.row].AdjPerc
            threeBestToSend = pins[indexPath.row].ThreeBest
            h2hToSend = pins[indexPath.row].H2H
            rankToSend = pins[indexPath.row].rank
            
            self.performSegue(withIdentifier: "pinsProfile", sender: self)
            
        }

    }
