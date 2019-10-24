//
//  BigWinsViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/22/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class BigWinsViewController: UIViewController,BigWinsModelDelegate, UITableViewDataSource, UITableViewDelegate  {
    

    @IBOutlet weak var bigWinsLabel: UILabel!
    @IBOutlet weak var bigWinsViewController: UITableView!


    var bigWinsModel = BigWinsModel()
        
    var bigWins = [BigWin]()
    
    var rankstate: String? = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            rankstate = stateName.thisState

            bigWinsViewController.delegate = self
            bigWinsViewController.dataSource = self
            
            bigWinsModel.getItems(rankstate!)
            bigWinsModel.delegate = self
           let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))

           let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
           imageView.contentMode = .scaleAspectFit
           let image = UIImage(named: "rwlogo")
           imageView.image = image
           imageView.tintColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
           logoContainer.addSubview(imageView)
           navigationItem.titleView = logoContainer
            navigationController?.navigationBar.barTintColor = UIColor.black
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)]
            tabBarController?.tabBar.barTintColor = UIColor.black
            tabBarController?.tabBar.tintColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
            
            bigWinsLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
        }

    func ItemsDownloaded(bigWins: [BigWin]) {
        self.bigWins = bigWins
        bigWinsViewController.reloadData()
    }

         
        // MARK: - UITableView Delegate Methods
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return bigWins.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigWinsCell", for: indexPath)
            var thisDate: String! = bigWins[indexPath.row].matchdate.components(separatedBy: " ").first
            let start = String.Index(encodedOffset:5)
            let end = String.Index(encodedOffset: 10)
            thisDate = String(thisDate[start..<end])
            let firstChar = String(thisDate[String.Index(encodedOffset:0)..<String.Index(encodedOffset:1)])
            if firstChar == "0" {
                thisDate = String(thisDate[String.Index(encodedOffset:1)..<String.Index(encodedOffset:5)])
            }
            thisDate = thisDate.replacingOccurrences(of: "-", with: "/")
            cell.textLabel?.text = thisDate! + ": " + bigWins[indexPath.row].winner + " (" + bigWins[indexPath.row].winningschool + ") C"  +  bigWins[indexPath.row].thisclass + "#" + bigWins[indexPath.row].myrank + " over " + bigWins[indexPath.row].loser + " (" + bigWins[indexPath.row].losingschool + ") C"  +  bigWins[indexPath.row].oppclass + "#" + bigWins[indexPath.row].opprank + " (" + bigWins[indexPath.row].matchresult + ": " + bigWins[indexPath.row].venue + ")"
            cell.textLabel?.numberOfLines = 0
            return cell
            
        }
     

 
    }
