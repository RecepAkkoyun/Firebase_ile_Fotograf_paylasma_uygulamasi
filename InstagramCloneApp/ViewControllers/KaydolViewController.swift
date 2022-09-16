//
//  KaydolViewController.swift
//  InstagramCloneApp
//
//  Created by Recep Akkoyun on 15.09.2022.
//

import UIKit
import Firebase

class KaydolViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSifre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func klavyeyiKapat() {
        view.endEditing(true)
    }

    @IBAction func btnKaydol(_ sender: Any) {
        if txtEmail.text != "" && txtSifre.text != "" {
           ///firebase'e yeni kayıt lan kullanıcılalrı kaydeder.
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtSifre.text!) { AuthDataResult, Error in
                if Error != nil {
                    self.hataMesaji(titleInmup: "Hata", messageInput: Error?.localizedDescription ?? "Hata Aldınız.")
                }else{
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
            }
        }
        else{
            hataMesaji(titleInmup: "Hata", messageInput: "Email veya Şifre boş geçilemez!")
        }
    }
    
    func hataMesaji(titleInmup : String, messageInput : String) {
        let alert = UIAlertController(title: titleInmup, message: messageInput, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
