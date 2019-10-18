//
//  RankOptionsTableViewController.swift
//  RankingPage
//
//  Created by RankWresters on 10/7/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class RankOptionsTableViewController: UITableViewController {

    //Mark: Properties
    
    var options = ["Class Rankings","Team Rankings","Grade Rankings","Pin Rankings"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RankOptionsTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let option = options[indexPath.row]

        cell.textLabel!.text = option
        cell.textLabel!.font = UIFont.systemFont(ofSize: 30.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let segueIdentifier: String
        switch indexPath.row {
        case 0:
            segueIdentifier = "classView"
        default:
            segueIdentifier = "classView"
        
        }
        self.performSegue(withIdentifier:segueIdentifier, sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
