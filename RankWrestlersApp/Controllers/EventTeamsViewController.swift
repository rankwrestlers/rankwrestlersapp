//
//  EventTeamsViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/22/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class EventTeamsViewController: UIViewController,TeamsModelDelegate,UITableViewDataSource,UITableViewDelegate {

      @IBOutlet weak var eventTeamsLabel: UILabel!

    @IBOutlet weak var eventTeamsViewController: UITableView!
    
    @IBOutlet weak var eventTeamsButton: UIButton!
    @IBAction func next(_ sender: Any) {
        var selectedSchools = teams.filter {
            $0.chosen
        }
        let theseTeams = selectedSchools.map { $0.school }
        print (theseTeams)
    }

        var school:String? = ""
        var rankstate:String? = ""
       
        var teamsModel = TeamsModel()
        var packingList = [Team]()

        var teams = [Team]()

        override func viewDidLoad() {
            super.viewDidLoad()
            rankstate = stateName.thisState
            eventTeamsViewController.allowsMultipleSelection = true

            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            numberFormatter.minimumFractionDigits = 1
            numberFormatter.maximumFractionDigits = 1

            eventTeamsViewController.delegate = self
            eventTeamsViewController.dataSource = self
            eventTeamsViewController.estimatedRowHeight = 20
            eventTeamsViewController.rowHeight = UITableView.automaticDimension
            
            teamsModel.getItems(rankstate!)
            teamsModel.delegate = self
            
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
            eventTeamsLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
            eventTeamsButton.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)

        }
        
        func ItemsDownloaded(teams: [Team]) {
            self.teams = teams
            eventTeamsViewController.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
            return teams.count
        
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventTeamsCell", for: indexPath)
            cell.textLabel?.text = teams[indexPath.row].school + " (Class " + teams[indexPath.row].rankclass + ")"
            return cell
        }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // Unselect the row, and instead, show the state with a checkmark.
       tableView.deselectRow(at: indexPath, animated: false)
       
       guard let cell = tableView.cellForRow(at: indexPath) else { return }
       
       // Update the selected item to indicate whether the user packed it or not.
       let item = teams[indexPath.row]
       let newItem = Team(school: item.school, chosen: !item.chosen)
       // Show a check mark next to packed items.
       if newItem.chosen {
           cell.accessoryType = .checkmark
        teams[indexPath.row].chosen = true
       } else {
           cell.accessoryType = .none
        teams[indexPath.row].chosen = false
       }
   }

 
    }
