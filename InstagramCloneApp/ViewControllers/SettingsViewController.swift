//
//  SettingsViewController.swift
//  InstagramCloneApp
//
//  Created by Recep Akkoyun on 13.09.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblEmail.text = Auth.auth().currentUser?.email
        
    }
    
    @IBAction func btnCikis(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
            
        }catch{
            print("Hata")
            
            
        }
    }
}
