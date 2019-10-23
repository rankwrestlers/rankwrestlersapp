//
//  profileViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/6/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, MatchesModelDelegate, UITableViewDataSource, UITableViewDelegate {

//MARK: Properties
    
    @IBOutlet weak var profileViewController: UITableView!
    @IBOutlet weak var wrestlerNameLabel: UILabel!    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var weightClassLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var adjPercLabel: UILabel!
    @IBOutlet weak var top3Label: UILabel!
    @IBOutlet weak var h2hLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    var wrestlerId:Location?
    
    var myString:String? = ""
    var wrestlerName:String? = ""
    var schoolName:String? = ""
    var grade:String? = ""
    var weightClass:String? = ""
    var totalScore:String! = ""
    var Wins:String! = ""
    var Losses:String! = ""
    var adjPerc:String! = ""
    var top3:String! = ""
    var H2H:String! = ""
    var rank:String! = ""
    var rankstate:String! = ""
    
    var matchesModel = MatchesModel()
    
    var matches = [Match]()
 

    @IBOutlet weak var profileMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1

        profileViewController.delegate = self
        profileViewController.dataSource = self
        profileViewController.estimatedRowHeight = 20
        profileViewController.rowHeight = UITableView.automaticDimension
        
        matchesModel.getItems(rankstate!,myString!)

        matchesModel.delegate = self
        wrestlerNameLabel.text = wrestlerName
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: (schoolName)!, attributes: underlineAttribute)
        schoolNameLabel.attributedText = underlineAttributedString
        schoolNameLabel.text = schoolName
        weightClassLabel.text = weightClass! + " (" + grade! + ")"
        recordLabel.text = Wins + "-" + Losses
        let thisTotalScore = Double(totalScore)
        totalScoreLabel.text = numberFormatter.string(from: thisTotalScore! as NSNumber)
        let thisAdjPerc = Double(adjPerc)
        adjPercLabel.text = numberFormatter.string(from: thisAdjPerc! as NSNumber)
        let thisH2H = Double(H2H)
        h2hLabel.text = numberFormatter.string(from: thisH2H! as NSNumber)
        let thisTop3 = Double(top3)
        top3Label.text = numberFormatter.string(from: thisTop3! as NSNumber)
        rankLabel.text = "#" + rank
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
        wrestlerNameLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)

    }
    
    func ItemsDownloaded(matches: [Match]) {
        self.matches = matches
        profileViewController.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableViewController: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return matches.count
        
    }
    
    func tableView(_ tableViewController: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Recent Matches:"
    }
    
    
    func tableView(_ tableViewController: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableViewController: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewController.dequeueReusableCell(withIdentifier: "theseMatchesCell", for: indexPath)
        
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
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         if segue.identifier != "profileMenuButton" {

        let info = segue.destination as! OpponentViewController
         info.opponent = opponentToSend
        info.rankstate = rankstateToSend
        }
      }
    
     var opponentToSend: String = ""
    var rankstateToSend: String = ""
     
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         opponentToSend = matches[indexPath.row].Opponent
        rankstateToSend = rankstate
         
         self.performSegue(withIdentifier: "opponentProfile", sender: self)
         
     }

    
}
