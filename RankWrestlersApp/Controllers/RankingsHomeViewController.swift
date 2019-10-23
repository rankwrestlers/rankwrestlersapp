//
//  RankingsHomeViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/13/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class RankingsHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var rankingHomeMenu: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
     @IBOutlet weak var rankingOptionsLabel: UILabel!
    
    var rankstate: String? = ""
    var rankstateName: String? = ""

    var options = ["Class Rankings","Team Rankings","Grade Rankings","Pin Rankings"]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        rankingOptionsLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
        rankingOptionsLabel.text = (rankstateName ?? "") + " Rankings"
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingsHomeCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30.0)
        cell.contentView.layoutMargins.left = 50

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "rankingHomeMenu" {

        switch segueIdentifier {
        case "classView":
            let info = segue.destination as! WeightOptionsViewController
            info.rankstate = rankstateToSend
        case "teamClasses":
            let info = segue.destination as! TeamClassesViewController
            info.rankstate = rankstateToSend
        case "gradeRankings":
            let info = segue.destination as! GradeOptionsViewController
            info.rankstate = rankstateToSend
        case "pinRankings":
            let info = segue.destination as! PinsViewController
            info.rankstate = rankstateToSend
        default:
            let info = segue.destination as! WeightOptionsViewController
//            info.rankstate = rankstateToSend
            }
    
        }
     }
    
    var rankstateToSend: String = ""
    var segueIdentifier: String = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            segueIdentifier = "classView"
        case 1:
            segueIdentifier = "teamClasses"
        case 2:
            segueIdentifier = "gradeRankings"
        case 3:
            segueIdentifier = "pinRankings"
        default:
            segueIdentifier = "classView"
        
        }
        rankstateToSend = rankstate!
        self.performSegue(withIdentifier:segueIdentifier, sender: self)
    }

}
