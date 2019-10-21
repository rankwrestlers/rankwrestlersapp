//
//  GradeOptionsViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/20/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class GradeOptionsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var gradeOptionsLabel: UILabel!
    @IBOutlet weak var gradeOptionsViewController: UITableView!
    var options = ["Senior","Junior","Sophomore","Freshman"]
    var rankstate: String? = ""
        
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
            gradeOptionsLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)

  
        }

        // MARK: - Table view data source

        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return options.count
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier != "gradeOptionsMenu" {
            let info = segue.destination as! GradeRankingsViewController
            info.rankstate = rankStateToSend
            info.grade = gradeToSend
            }
         }

        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "gradeOptionsCell", for: indexPath)

            let option = options[indexPath.row]

            cell.textLabel!.text = option
            cell.textLabel!.font = UIFont.systemFont(ofSize: 30.0)
            cell.contentView.layoutMargins.left = 60

            return cell
        }
     var gradeToSend: String = ""
        var rankStateToSend: String = ""
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            gradeToSend = options[indexPath.row]
            rankStateToSend = "MO"
            
            self.performSegue(withIdentifier: "gradeDetail", sender: self)
            
        }
}
