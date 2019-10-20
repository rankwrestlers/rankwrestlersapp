//
//  TeamsViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/14/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController,TeamsModelDelegate, UITableViewDataSource, UITableViewDelegate  {
    

    @IBOutlet weak var teamsViewController: UITableView!

    @IBOutlet weak var teamsMenu: UIBarButtonItem!
    var school:String? = ""
    var rankstate:String? = ""
   
    var teamsModel = TeamsModel()

    var teams = [Team]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1

        teamsViewController.delegate = self
        teamsViewController.dataSource = self
        teamsViewController.estimatedRowHeight = 20
        teamsViewController.rowHeight = UITableView.automaticDimension
        
        teamsModel.getItems(rankstate!)
        teamsModel.delegate = self
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
    
    func ItemsDownloaded(teams: [Team]) {
        self.teams = teams
        teamsViewController.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return teams.count
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamsCell", for: indexPath)
        cell.textLabel?.text = teams[indexPath.row].school + " (Class " + teams[indexPath.row].rankclass + ")"
        return cell
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier != "teamsMenu" {

       let info = segue.destination as! RostersViewController
       info.school = schoolToSend
       info.rankstate = rankstateToSend
        }
    }
    
    var schoolToSend: String = ""
    var rankstateToSend: String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        schoolToSend = teams[indexPath.row].school
        rankstateToSend = "MO"
        
        self.performSegue(withIdentifier: "rostersView", sender: self)
        
    }
 
}
