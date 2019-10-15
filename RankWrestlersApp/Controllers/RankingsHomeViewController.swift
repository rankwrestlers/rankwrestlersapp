//
//  RankingsHomeViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/13/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class RankingsHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var options = ["Class Rankings","Team Rankings","Grade Rankings","Pin Rankings"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let info = segue.destination as! TeamClassesViewController
        info.rankstate = rankstateToSend
    
        
     }
    
    var rankstateToSend: String = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let segueIdentifier: String
        switch indexPath.row {
        case 0:
            segueIdentifier = "classView"
        case 1:
            segueIdentifier = "teamClasses"
        default:
            segueIdentifier = "classView"
        
        }
        rankstateToSend = "MO"
        self.performSegue(withIdentifier:segueIdentifier, sender: self)
    }

}
