//
//  TableViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 9/2/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, MatchesModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    
    

    
    var wrestlerId:Location?
    
    var myString:String? = ""
    var wrestlerName:String? = ""
    
    
    
    var matchesModel = MatchesModel()
    
    var matches = [Match]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileViewController.delegate = self
        profileViewController.dataSource = self
        profileViewController.estimatedRowHeight = 20
        profileViewController.rowHeight = UITableView.automaticDimension
        
        matchesModel.getItems(myString!)
        matchesModel.getItems(wrestlerName!)
        matchesModel.delegate = self
        
        
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
        return wrestlerName! + " Matches"
    }
    
    
    func tableView(_ tableViewController: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableViewController: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewController.dequeueReusableCell(withIdentifier: "theseMatchesCell", for: indexPath)
        
        if matches[indexPath.row].matchresult == "For." {
            cell.textLabel?.text = "Forfeit - " + matches[indexPath.row].losingschool
            cell.textLabel?.textColor = UIColor(red: 0.1059, green: 0.5882, blue: 0, alpha: 1.0)
        } else {
            
            let num = Double(matches[indexPath.row].AdjPerc) ?? 0
            
            var totalScore: String = ""
            
            if num > 0 {
                totalScore = String(round(Double(matches[indexPath.row].AdjPerc)!*1000)/10)
            } else {
                totalScore = "0"
            }
            
            if matches[indexPath.row].Result == "Win" {
                cell.textLabel?.text = matches[indexPath.row].loser + ", " + matches[indexPath.row].losingschool + ": " + totalScore + "%" + " - " + matches[indexPath.row].matchresult
                cell.textLabel?.textColor = UIColor(red: 0.1059, green: 0.5882, blue: 0, alpha: 1.0)
                
            } else {
                cell.textLabel?.text = matches[indexPath.row].winner + ", " + matches[indexPath.row].winningschool + ": " + totalScore + "%" + " - " + matches[indexPath.row].matchresult
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
