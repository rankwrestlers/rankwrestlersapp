//
//  ChangeStateViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/22/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class ChangeStateViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var changeStateViewController: UITableView!
    @IBOutlet weak var changeStateLabel: UILabel!
 var rankstate: String? = ""

    
    var options = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]

     override func viewDidLoad() {
         super.viewDidLoad()
 
        rankstate = stateName.thisState

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
         changeStateLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)

     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return options.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "changeStateCell", for: indexPath)
         cell.textLabel?.text = options[indexPath.row]
         cell.textLabel?.font = UIFont.systemFont(ofSize: 25.0)
         cell.contentView.layoutMargins.left = 55

         return cell
     }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier != "changeStateMenu" {
        let info = segue.destination as! RankingsHomeViewController
        info.rankstate = rankstateToSend
        info.rankstateName = rankstateName
       }
     }

    
    var rankstateName: String = ""
    var rankstateToSend: String = ""
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        rankstateName = options[indexPath.row]
         switch rankstateName {
         case "Alabama":
             rankstateToSend = "AL"
         case "Alaska":
             rankstateToSend = "AK"
         case "Arizona":
             rankstateToSend = "AZ"
         case "Arkansas":
             rankstateToSend = "AR"
         case "California":
             rankstateToSend = "CA"
         case "Colorado":
             rankstateToSend = "CO"
         case "Connecticut":
             rankstateToSend = "CT"
         case "Delaware":
             rankstateToSend = "DE"
         case "Florida":
             rankstateToSend = "FL"
         case "Georgia":
             rankstateToSend = "GA"
         case "Hawaii":
             rankstateToSend = "HA"
         case "Idaho":
             rankstateToSend = "ID"
         case "Illinois":
             rankstateToSend = "IL"
         case "Indiana":
             rankstateToSend = "IN"
         case "Iowa":
             rankstateToSend = "IA"
         case "Kansas":
             rankstateToSend = "KS"
         case "Kentucky":
             rankstateToSend = "KY"
         case "Louisiana":
             rankstateToSend = "LA"
         case "Maine":
             rankstateToSend = "ME"
         case "Maryland":
             rankstateToSend = "MD"
         case "Massachusetts":
             rankstateToSend = "MA"
         case "Michigan":
             rankstateToSend = "MI"
         case "Minnesota":
             rankstateToSend = "MN"
         case "Missouri":
             rankstateToSend = "MO"
         case "Montana":
             rankstateToSend = "MT"
         case "Nebraska":
             rankstateToSend = "NE"
         case "New Hampshire":
             rankstateToSend = "NH"
         case "Nevade":
             rankstateToSend = "NV"
         case "New Jersey":
             rankstateToSend = "NJ"
         case "New York":
             rankstateToSend = "NY"
         case "New Mexico":
             rankstateToSend = "NM"
         case "North Dakota":
             rankstateToSend = "ND"
         case "Ohio":
             rankstateToSend = "OH"
         case "Oklahoma":
             rankstateToSend = "OK"
         case "Oregon":
             rankstateToSend = "OR"
         case "Pennsylvania":
             rankstateToSend = "PA"
         case "Rhode Island":
             rankstateToSend = "RI"
         case "South Carolina":
             rankstateToSend = "SC"
         case "South Dakota":
             rankstateToSend = "SD"
         case "Tennessee":
             rankstateToSend = "TN"
         case "Texas":
             rankstateToSend = "TX"
         case "Utah":
             rankstateToSend = "UT"
         case "Vermont":
             rankstateToSend = "VT"
         case "West Virginia":
             rankstateToSend = "WV"
         case "North Carolina":
            rankstateToSend = "NC"
        case "Virginia":
            rankstateToSend = "VA"
        case "Washington":
            rankstateToSend = "WA"
        case "Wisconsin":
            rankstateToSend = "WI"
        case "Wyoming":
            rankstateToSend = "WY"
        default:
             rankstateToSend = "AL"
         }
        stateName.thisState = rankstateToSend
        self.performSegue(withIdentifier:"changeStateRankings", sender: self)
     }

    
}
