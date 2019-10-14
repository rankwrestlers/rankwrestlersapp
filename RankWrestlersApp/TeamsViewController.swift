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
        // Do any additional setup after loading the view.
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

 
}
