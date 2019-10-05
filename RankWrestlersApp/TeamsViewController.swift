//
//  ViewController.swift
//  TeamViewTest
//
//  Created by RankWresters on 9/4/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController, TeamModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var teamView: UITableView!
    var teamModel = TeamModel()
    
    var teams = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set self as the tableview's data source and delegate
        teamView.delegate = self
        teamView.dataSource = self
        
        // Initiate calling the items download
        teamModel.getItems()
        teamModel.delegate = self
        
    }
    
    func itemsDownloaded(teams: [Team]) {
        
        self.teams = teams
        teamView.reloadData()
        
    }
    
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return teams.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        
        cell.textLabel?.text = teams[indexPath.row].school + " (" + teams[indexPath.row].thisclass + ")"
        
        return cell
        
    }
    
}
