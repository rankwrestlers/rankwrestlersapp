//
//  RankDetailViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/13/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class RankDetailViewController: UIViewController,RankingsModelDelegate, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var rankDetailLabel: UILabel!
    
    @IBOutlet weak var rankDetailTableView: UITableView!

    var rankweight:String? = ""
    var weight:String? = ""
    var classname:String? = ""
    var rankclass:String? = ""
    var rankstate:String? = ""
    var wrestler:String? = ""
    var wrestlername:String? = ""
    var school:String? = ""
    var grade:String? = ""
    var Wins:String? = ""
    var Losses:String? = ""
    var Combo:String? = ""
    var AdjPerc:String? = ""
    var ThreeBest:String? = ""
    var H2H:String? = ""
    var rank:String? = ""
    var rankingsModel = RankingsModel()
    
    var rankings = [Ranking]()

    override func viewDidLoad() {
        super.viewDidLoad()

        rankDetailLabel.text = weight! + " Pounds - Class " + rankclass!
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1

        rankDetailTableView.delegate = self
        rankDetailTableView.dataSource = self
        rankDetailTableView.estimatedRowHeight = 20
        rankDetailTableView.rowHeight = UITableView.automaticDimension
        
        rankingsModel.getItems(rankclass!,rankstate!,rankweight!)
        rankingsModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func ItemsDownloaded(rankings: [Ranking]) {
        self.rankings = rankings
        rankDetailTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rankings.count
    
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankDetailCell", for: indexPath)
        let num = Double(rankings[indexPath.row].Combo) ?? 0
        
        var thisScore: String = ""
        
        if num > 0 {
            thisScore = String(round(Double(rankings[indexPath.row].Combo)!*1000)/10)
        } else {
            thisScore = "0"
        }
        cell.textLabel?.text = "#" + String(indexPath.row + 1) + " - " + rankings[indexPath.row].wrestlername + " (" + rankings[indexPath.row].school + "): " + thisScore + "%"
        return cell
    }
        
    

}
