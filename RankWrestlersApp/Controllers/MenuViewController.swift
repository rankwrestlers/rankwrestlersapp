//
//  MenuViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/18/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menuViewController: UITableView!
 
    @IBOutlet weak var menuLabel: UILabel!
    var options = ["Home","Rankings","Rosters","Big Wins","All Americans","Meet / Tourney Guide","College Rankings","Change State"]
    
    
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
        menuLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30.0)
        cell.contentView.layoutMargins.left = 60
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "rankingHomeMenu" {
            
            switch segueIdentifier {
            case "followingPage":
                let info = segue.destination as! FollowingViewController
            //            info.rankstate = rankstateToSend
            case "rankingsPage":
                let info = segue.destination as! RankingsHomeViewController
            //            info.rankstate = rankstateToSend
            case "rostersPage":
                let info = segue.destination as! TeamsViewController
            //            info.rankstate = rankstateToSend
            case "bigWinsPage":
                let info = segue.destination as! BigWinsViewController
                info.rankstate = rankstateToSend
            case "allAmericansPage":
                let info = segue.destination as! AllAmericansViewController
                info.rankstate = rankstateToSend
            default:
                let info = segue.destination as! FollowingViewController
                //            info.rankstate = rankstateToSend
            }
            
        }
    }
    var rankstateToSend: String = ""
    var segueIdentifier: String = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            segueIdentifier = "followingPage"
        case 1:
            segueIdentifier = "rankingsPage"
        case 2:
            segueIdentifier = "rostersPage"
        case 3:
            segueIdentifier = "bigWinsPage"
        case 4:
            segueIdentifier = "allAmericansPage"
        default:
            segueIdentifier = "followingPage"
            
        }
        rankstateToSend = "MO"
        self.performSegue(withIdentifier:segueIdentifier, sender: self)
    }
    
}
