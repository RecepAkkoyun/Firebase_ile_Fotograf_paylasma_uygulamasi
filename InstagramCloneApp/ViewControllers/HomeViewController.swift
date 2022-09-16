//
//  HomeViewController.swift
//  InstagramCloneApp
//
//  Created by Recep Akkoyun on 13.09.2022.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    
    
    @IBOutlet weak var tableView: UITableView!
    var emailDizisi = [String]()
    var yorumDizisi = [String]()
    var gorselIdDizisi = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        firebaseVerileriAl()
        
    }
    
    func firebaseVerileriAl() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").order(by: "tarih", descending: true) // tarihe göre sırala dedim.
            .addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot?.isEmpty != nil {
                    self.emailDizisi.removeAll(keepingCapacity: false)
                    self.yorumDizisi.removeAll(keepingCapacity: false)
                    self.gorselIdDizisi.removeAll(keepingCapacity: false)
                    
                    for documents in snapshot!.documents {
                        if let gorselUrl = documents.get("gorselId") as? String {
                            self.gorselIdDizisi.append(gorselUrl)
                        }
                        if let email = documents.get("email") as? String {
                            self.emailDizisi.append(email)
                        }
                        if let yorum = documents.get("yorum") as? String {
                            self.yorumDizisi.append(yorum)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailDizisi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        cell.lblEmail.text = emailDizisi[indexPath.row]
        cell.lblYorum.text = yorumDizisi[indexPath.row]
        cell.postImageView?.sd_setImage(with: URL(string: self.gorselIdDizisi[indexPath.row]))
        return cell
    }

}
