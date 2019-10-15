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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamClassesViewController.delegate = self
        teamClassesViewController.dataSource = self
             
         teamClassesModel.getItems(rankstate!)
         teamClassesModel.delegate = self

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

 

}
