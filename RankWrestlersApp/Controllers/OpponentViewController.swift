//
//  OpponentViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/16/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//
import Foundation
import UIKit

class OpponentViewController: UIViewController,MatchesModelDelegate,OpponentsModelDelegate,UITableViewDataSource,UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var opponentViewController: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var adjPercLabel: UILabel!
    @IBOutlet weak var top3Label: UILabel!
    @IBOutlet weak var h2hLabel: UILabel!
    
    var opponent:String? = ""
    var rankstate:String? = ""
    var wrestlername:String? = ""

    
    var opponentsModel = OpponentsModel()
    
    var opponents = [Opponent]()

    var matchesModel = MatchesModel()
       
    var matches = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        opponentViewController.delegate = self
        opponentViewController.dataSource = self
        opponentsModel.getItems(rankstate!,opponent!)
        opponentsModel.delegate = self
        matchesModel.getItems(opponent!)
        matchesModel.delegate = self

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
        // Do any additional setup after loading the view.
    }
    
    func ItemsDownloaded(matches: [Match]) {
        self.matches = matches
        opponentViewController.reloadData()

    }

    func ItemsDownloaded(opponents: [Opponent]) {
        self.opponents = opponents
        opponentViewController.reloadData()
    }

  func tableView(_ tableViewController: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Recent Matches:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
 

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1
        let cell = opponentViewController.dequeueReusableCell(withIdentifier: "opponentCell", for: indexPath)
        if opponents.count < 1 {
            cell.textLabel!.text = "This wrestler graduated.  Match info not available."
            return cell
        } else {
        nameLabel.text = opponents[0].wrestlername
        schoolLabel.text = opponents[0].school
        weightLabel.text = opponents[0].rankweight + " (" + opponents[0].grade + ")"
        let thisTotalScore = Double(opponents[0].Combo)
        scoreLabel.text = numberFormatter.string(from: thisTotalScore! as NSNumber)
        rankLabel.text = "#" + opponents[0].rank
        recordLabel.text = opponents[0].Wins + "-" + opponents[0].Losses
        let thisAdjPerc = Double(opponents[0].AdjPerc)
        adjPercLabel.text = numberFormatter.string(from: thisAdjPerc! as NSNumber)
        let thisH2H = Double(opponents[0].H2H)
        h2hLabel.text = numberFormatter.string(from: thisH2H! as NSNumber)
        let thisTop3 = Double(opponents[0].ThreeBest)
        top3Label.text = numberFormatter.string(from: thisTop3! as NSNumber)

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "M/d"
        
        var thismatchdate:String? = ""
        
        if let thisdate = dateFormatterGet.date(from: matches[indexPath.row].matchdate) {
            thismatchdate = dateFormatterPrint.string(from: thisdate)
        } else {
            thismatchdate = ""
        }
        
        if matches[indexPath.row].matchresult == "For." {
            cell.textLabel?.text = thismatchdate! + ": Forfeit - " + matches[indexPath.row].losingschool
            cell.textLabel?.textColor = UIColor(red: 0.1059, green: 0.5882, blue: 0, alpha: 1.0)
        } else {
            
            let num = Double(matches[indexPath.row].AdjPerc) ?? 0
            
            var thisScore: String = ""
            
            if num > 0 {
                thisScore = String(round(Double(matches[indexPath.row].AdjPerc)!*1000)/10)
            } else {
                thisScore = "0"
            }
            
            if matches[indexPath.row].Result == "Win" {
                cell.textLabel?.text = thismatchdate! + ": " + matches[indexPath.row].loser + ", " + matches[indexPath.row].losingschool + " (" + thisScore + "%)" + " - " + matches[indexPath.row].matchresult
                cell.textLabel?.textColor = UIColor(red: 0.1059, green: 0.5882, blue: 0, alpha: 1.0)
                cell.textLabel?.numberOfLines = 0
            } else {
                cell.textLabel?.text = thismatchdate! + ": " + matches[indexPath.row].winner + ", " + matches[indexPath.row].winningschool + " (" + thisScore + "%)" + " - " + matches[indexPath.row].matchresult
                cell.textLabel?.textColor = UIColor.red
                cell.textLabel?.numberOfLines = 0
            }
        }
         return cell
        }
    }

}
