//
//  TeamClassesViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/14/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class TeamClassesViewController: UIViewController,TeamClassesModelDelegate,UITableViewDataSource, UITableViewDelegate {
    
 
    var teamClassesModel = TeamClassesModel()
     
    var teamClasses = [TeamClass]()
     
    var rankclass:String? = ""
    var rankstate:String? = ""

   
    @IBOutlet weak var teamClassesViewController: UITableView!
    
    @IBOutlet weak var teamClassesLabel: UILabel!

    @IBOutlet weak var teamClassesMenu: UIBarButtonItem!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        teamClassesViewController.delegate = self
        teamClassesViewController.dataSource = self
             
         teamClassesModel.getItems(rankstate!)
         teamClassesModel.delegate = self
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
          teamClassesLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)


    }

    func ItemsDownloaded(teamClasses: [TeamClass]) {
        self.teamClasses = teamClasses
        teamClassesViewController.reloadData()
     }
         
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return teamClasses.count

         
         }

         func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return UITableView.automaticDimension
         }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamClassCell", for: indexPath)
        cell.textLabel?.text = "Class " + teamClasses[indexPath.row].rankclass
        cell.textLabel!.font = UIFont.systemFont(ofSize: 30.0)

         return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier != "teamClassesMenu" {

       let info = segue.destination as! TeamRankingsViewController
       info.rankclass = rankclassToSend
       info.rankstate = rankstateToSend
        }
    }
    
    var rankclassToSend: String = ""
    var rankstateToSend: String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rankclassToSend = teamClasses[indexPath.row].rankclass
        rankstateToSend = "MO"
        
        self.performSegue(withIdentifier: "teamRankings", sender: self)
        
    }

 

}
