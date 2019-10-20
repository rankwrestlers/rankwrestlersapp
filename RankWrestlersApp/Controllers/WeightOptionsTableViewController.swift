//
//  WeightOptionsTableViewController.swift
//  RankingPage
//
//  Created by RankWresters on 10/8/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

var rankstate:String = ""

class WeightOptionsTableViewController: UITableViewController {
    
    @IBOutlet var weightTableView: UITableView!
    
    @IBOutlet weak var weightOptionsMenu: UIBarButtonItem!

    var tableViewData = [cellData]()
    
    var rankstate: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewData = [cellData(opened:false,title:"Class 1",sectionData:["106","113","120","126","132","138","145","152","160","170","195","220","285"]),cellData(opened:false,title:"Class 2",sectionData:["106","113","120","126","132","138","145","152","160","170","195","220","285"]),cellData(opened:false,title:"Class 3",sectionData:["106","113","120","126","132","138","145","152","160","170","195","220","285"]),cellData(opened:false,title:"Class 4",sectionData:["106","113","120","126","132","138","145","152","160","170","195","220","285"])]

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
         
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return tableViewData.count

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
        
    }

  
/*    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        if section == 0 {
            return "Class Rankings"
        } else {
            return ""
        }
    }
*/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "thiscell") else {return UITableViewCell()}
        
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.textLabel!.font = UIFont.systemFont(ofSize: 25.0)
            
            return cell
            
        } else {
            
            // use different cell identifier if needed
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "thiscell") else {return UITableViewCell()}

            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
            cell.textLabel!.font = UIFont.systemFont(ofSize: 20.0)
            
            return cell

        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        if segue.identifier != "weightOptionsMenu" {

        let info = segue.destination as! RankDetailViewController
        info.weight = weightToSend
        info.classname = classToSend
        info.rankclass = rankclassToSend
        info.rankweight = weightToSend
        info.rankstate = rankstateToSend
        }
        
     }
    
    var weightToSend: String = ""
    var classToSend: String = ""
    var rankclassToSend: String = ""
    var rankstateToSend: String = ""

    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none) //play around with this
                
            } else {
                
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none) //play around with this

            }
        
        } else {
        classToSend = tableViewData[indexPath.section].title
        weightToSend = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
        rankclassToSend = String(classToSend.suffix(1))
        rankstateToSend = "MO"
        self.performSegue(withIdentifier: "rankDetailView", sender: self)
        }
    }

}
