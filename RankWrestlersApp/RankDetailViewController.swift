//
//  RankDetailViewController.swift
//  RankWrestlersApp
//
//  Created by RankWresters on 10/13/19.
//  Copyright © 2019 RankWresters. All rights reserved.
//

import UIKit

class RankDetailViewController: UIViewController {

    @IBOutlet weak var rankDetailLabel: UILabel!
    
    var weight:String? = ""
    var classname:String? = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        rankDetailLabel.text = classname! + ": " + weight!

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
