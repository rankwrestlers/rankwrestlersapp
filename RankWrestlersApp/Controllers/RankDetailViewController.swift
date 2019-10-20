//
//  RankDetailViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/13/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class RankDetailViewController: UIViewController,RankingsModelDelegate, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var rankDetailLabel: UILabel!
    
    @IBOutlet weak var rankDetailTableView: UITableView!
    @IBOutlet weak var rankDetailMenu: UIBarButtonItem!
    
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
 
    var rankingsModel = RankingsModel()
    
    var rankings = [Ranking]()

    override func viewDidLoad() {
        super.viewDidLoad()

        rankDetailLabel.text = weight! + " Pounds - Class " + rankclass!
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1

        rankDetailTableView.delegate = self
        rankDetailTableView.dataSource = self
        rankDetailTableView.estimatedRowHeight = 20
        rankDetailTableView.rowHeight = UITableView.automaticDimension
        
        rankingsModel.getItems(rankclass!,rankstate!,rankweight!)
        rankingsModel.delegate = self
        // Do any additional setup after loading the view.
               let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))

               let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
               imageView.contentMode = .scaleAspectFit
               let image = UIImage(named: "rwlogo")
               imageView.image = image
               logoContainer.addSubview(imageView)
               navigationItem.titleView = logoContainer
                navigationController?.navigationBar.barTintColor = UIColor.black
                tabBarController?.tabBar.barTintColor = UIColor.black
               tabBarController?.tabBar.tintColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
        

    }
    
    func ItemsDownloaded(rankings: [Ranking]) {
        self.rankings = rankings
        rankDetailTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rankings.count
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
    if segue.identifier != "rankDetailMenu" {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankDetailCell", for: indexPath)
        let num = Double(rankings[indexPath.row].Combo) ?? 0
        
        var thisScore: String = ""
        
        if num > 0 {
            thisScore = String(round(Double(rankings[indexPath.row].Combo)!*1000)/10)
        } else {
            thisScore = "0"
        }
        cell.textLabel?.text = "#" + String(indexPath.row + 1) + " - " + rankings[indexPath.row].wrestlername + " (" + rankings[indexPath.row].school + "): " + thisScore + "%"
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
        textToSend = rankings[indexPath.row].wrestler
        wrestlerNameToSend = rankings[indexPath.row].wrestlername
        schoolNameToSend = rankings[indexPath.row].school
        gradeToSend = rankings[indexPath.row].grade
        weightClassToSend = rankings[indexPath.row].rankweight
        winsToSend = rankings[indexPath.row].Wins
        lossesToSend = rankings[indexPath.row].Losses
        totalScoreToSend = rankings[indexPath.row].Combo
        adjPercToSend = rankings[indexPath.row].AdjPerc
        threeBestToSend = rankings[indexPath.row].ThreeBest
        h2hToSend = rankings[indexPath.row].H2H
        rankToSend = rankings[indexPath.row].rank
        
        self.performSegue(withIdentifier: "showProfile", sender: self)
        
    }

}
