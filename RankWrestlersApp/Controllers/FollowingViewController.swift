//
//  ViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 9/1/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class FollowingViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var followingLabel: UILabel!
    

    @IBAction func menuBarButton(_ sender: UIBarButtonItem) {
 
    }
    

    var homeModel = HomeModel()
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        homeModel.getItems()
        homeModel.delegate = self
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
        
        followingLabel.backgroundColor = UIColor(red:0.85, green:0.78, blue:0.58, alpha:1.0)
    }

    func ItemsDownloaded(locations: [Location]) {
        self.locations = locations
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier != "mainMenu" {
        let info = segue.destination as! ProfileViewController
        info.myString = textToSend
        info.wrestlerName = wrestlerNameToSend
        info.schoolName = schoolNameToSend
        info.grade = gradeToSend
        info.totalScore = totalScoreToSend
        info.adjPerc = adjPercToSend
        info.H2H = h2hToSend
        info.top3 = threeBestToSend
        info.Wins = winsToSend
        info.Losses = lossesToSend
        info.weightClass = weightClassToSend + " lbs"
        info.rank = rankToSend
        }
     }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell", for: indexPath)
        
        let totalScore = round(Double(locations[indexPath.row].Combo)!*1000)/10
        
        cell.textLabel?.text = locations[indexPath.row].wrestlername + ", " + locations[indexPath.row].school + " (" + String(totalScore) + "%)"
        cell.textLabel?.numberOfLines = 0
        return cell
        
    }
 

    var textToSend: String = ""
    var wrestlerNameToSend: String = ""
    var schoolNameToSend: String = ""
    var weightClassToSend: String = ""
    var winsToSend: String = ""
    var lossesToSend: String = ""
    var totalScoreToSend: String = ""
    var adjPercToSend: String = ""
    var h2hToSend: String = ""
    var threeBestToSend: String = ""
    var gradeToSend: String = ""
    var rankToSend: String = ""
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textToSend = locations[indexPath.row].wrestler
        wrestlerNameToSend = locations[indexPath.row].wrestlername
        schoolNameToSend = locations[indexPath.row].school
        gradeToSend = locations[indexPath.row].grade
        weightClassToSend = locations[indexPath.row].rankweight
        winsToSend = locations[indexPath.row].Wins
        lossesToSend = locations[indexPath.row].Losses
        totalScoreToSend = locations[indexPath.row].Combo
        adjPercToSend = locations[indexPath.row].AdjPerc
        threeBestToSend = locations[indexPath.row].ThreeBest
        h2hToSend = locations[indexPath.row].H2H
        rankToSend = locations[indexPath.row].rank
        
        self.performSegue(withIdentifier: "GoToMatches", sender: self)
        
    }

}
