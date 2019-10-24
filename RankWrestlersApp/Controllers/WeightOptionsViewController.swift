//
//  WeightOptionsViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/22/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class WeightOptionsViewController: UIViewController,TeamClassesModelDelegate,UITableViewDataSource, UITableViewDelegate {
 
    
    @IBOutlet weak var weightOptionsLabel: UILabel!
    
    @IBOutlet weak var weightOptionsViewController: UITableView!
    var rankclass:String? = ""
    var rankstate:String? = ""
    var teamClassesModel = TeamClassesModel()
     
    var teamClasses = [TeamClass]()

    struct cellData {
        var opened = Bool()
        var title = String()
        var sectionData = [String]()
    }
    var tableViewData = [cellData]()
    
    // need to add if for idaho, ny and mi
    var weightClasses = ["106","113","120","126","132","138","145","152","160","170","195","220","285"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rankstate = stateName.thisState

        weightOptionsViewController.delegate = self
        weightOptionsViewController.dataSource = self
             
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
          weightOptionsLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
    }
        func ItemsDownloaded(teamClasses: [TeamClass]) {
            self.teamClasses = teamClasses
            switch teamClasses.count {
            case 2:
            tableViewData = [cellData(opened:false,title:teamClasses[0].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[1].rankclass,sectionData:weightClasses)]
            case 3:
            tableViewData = [cellData(opened:false,title:teamClasses[0].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[1].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[2].rankclass)]
            case 4:
            tableViewData = [cellData(opened:false,title:teamClasses[0].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[1].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[2].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[3].rankclass,sectionData:weightClasses)]
            case 5:
            tableViewData = [cellData(opened:false,title:teamClasses[0].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[1].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[2].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[3].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[4].rankclass,sectionData:weightClasses)]
            case 6:
            tableViewData = [cellData(opened:false,title:teamClasses[0].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[1].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[2].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[3].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[4].rankclass,sectionData:weightClasses),cellData(opened:false,title:teamClasses[5].rankclass,sectionData:weightClasses)]
            default:
                tableViewData = [cellData(opened:false,title:teamClasses[0].rankclass,sectionData:weightClasses)]

            }
                     
                weightOptionsViewController.reloadData()
        }
        

            // MARK: - Table view data source

            func numberOfSections(in tableView: UITableView) -> Int {

                return tableViewData.count

            }

            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
                if tableViewData[section].opened == true {
                    return tableViewData[section].sectionData.count + 1
                } else {
                    return 1
                }
                
            }

          
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let dataIndex = indexPath.row - 1
                if indexPath.row == 0 {
                    
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "weightOptionsCell") else {return UITableViewCell()}
                
                    cell.textLabel?.text = tableViewData[indexPath.section].title
                    cell.textLabel!.font = UIFont.systemFont(ofSize: 25.0)
                    
                    return cell
                    
                } else {
                    
                    // use different cell identifier if needed
                    
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "weightOptionsCell") else {return UITableViewCell()}

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

            func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
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
                rankclassToSend = tableViewData[indexPath.section].title
                weightToSend = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
               // rankclassToSend = String(classToSend.suffix(1))
                    rankstateToSend = rankstate!
                self.performSegue(withIdentifier: "rankDetail", sender: self)
                }
            }

        }
