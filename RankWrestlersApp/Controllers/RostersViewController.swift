//
//  RostersViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/14/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class RostersViewController: UIViewController,RostersModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var rostersLabel: UILabel!
    
    @IBOutlet weak var rostersViewController: UITableView!

    @IBOutlet weak var rostersMenu: UIBarButtonItem!
    var rankweight:String? = ""
    var weight:String? = ""
    var classname:String? = ""
    var rankclass:String? = ""
    var rankstate:String? = ""
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
    
    var rostersModel = RostersModel()
    
    var rosters = [Roster]()

    override func viewDidLoad() {
        super.viewDidLoad()
        rankstate = stateName.thisState

        rostersLabel.text = school! + " Roster"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1

        rostersViewController.delegate = self
        rostersViewController.dataSource = self
        rostersViewController.estimatedRowHeight = 20
        rostersViewController.rowHeight = UITableView.automaticDimension
        
        rostersModel.getItems(rankstate!,school!)
        rostersModel.delegate = self
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
        rostersLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)


    }

    func ItemsDownloaded(rosters: [Roster]) {
        self.rosters = rosters
        rostersViewController.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rosters.count
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier != "rostersMenu" {

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
      info.rankstate = rankStateToSend
     }
   }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rosterCell", for: indexPath)
        let num = Double(rosters[indexPath.row].Combo) ?? 0
        
        var thisScore: String = ""
        
        if num > 0 {
            thisScore = String(round(Double(rosters[indexPath.row].Combo)!*1000)/10)
        } else {
            thisScore = "0"
        }
        cell.textLabel?.text = rosters[indexPath.row].rankweight + " - #" + rosters[indexPath.row].rank + ", " + rosters[indexPath.row].wrestlername + " (" + rosters[indexPath.row].grade + "): " + thisScore + "%"
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
    var rankStateToSend: String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textToSend = rosters[indexPath.row].wrestler
        wrestlerNameToSend = rosters[indexPath.row].wrestlername
        schoolNameToSend = rosters[indexPath.row].school
        gradeToSend = rosters[indexPath.row].grade
        weightClassToSend = rosters[indexPath.row].rankweight
        winsToSend = rosters[indexPath.row].Wins
        lossesToSend = rosters[indexPath.row].Losses
        totalScoreToSend = rosters[indexPath.row].Combo
        adjPercToSend = rosters[indexPath.row].AdjPerc
        threeBestToSend = rosters[indexPath.row].ThreeBest
        h2hToSend = rosters[indexPath.row].H2H
        rankToSend = rosters[indexPath.row].rank
        rankStateToSend = rankstate!
        
        self.performSegue(withIdentifier: "rosterProfile", sender: self)
        
    }

}
