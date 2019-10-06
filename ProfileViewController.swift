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
    
    var matchesModel = MatchesModel()
    
    var matches = [Match]()
    
    
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
        
        matchesModel.getItems(myString!)

        matchesModel.delegate = self
        wrestlerNameLabel.text = wrestlerName
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
                cell.textLabel?.text = thismatchdate! + ": " + matches[indexPath.row].loser + ", " + matches[indexPath.row].losingschool + "(" + thisScore + "%)" + " - " + matches[indexPath.row].matchresult
                cell.textLabel?.textColor = UIColor(red: 0.1059, green: 0.5882, blue: 0, alpha: 1.0)
                
            } else {
                cell.textLabel?.text = thismatchdate! + ": " + matches[indexPath.row].winner + ", " + matches[indexPath.row].winningschool + " (" + thisScore + "%)" + " - " + matches[indexPath.row].matchresult
                cell.textLabel?.textColor = UIColor.red
            }
        }
        
        return cell
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
