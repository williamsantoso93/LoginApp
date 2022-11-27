//
//  HomeViewController.swift
//  LoginApp
//
//  Created by William Santoso on 27/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailLabel.text = email
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
