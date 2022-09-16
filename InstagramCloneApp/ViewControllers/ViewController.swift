//
//  ViewController.swift
//  InstagramCloneApp
//
//  Created by Recep Akkoyun on 13.09.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSifre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognizer)
    }
    @objc func klavyeyiKapat() {
        view.endEditing(true)
    }

    
    @IBAction func btnGirisYap(_ sender: Any) {
        ///Kayıtlı kullanıcıyı kontrol edip giriş yapmamızı sağlar.
        if txtEmail.text != "" && txtSifre.text != "" {
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtSifre.text!) { authdataresult, error in
                if error != nil { self.hataMesaji(titleInmup: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                    
                }else{
                    self.performSegue(withIdentifier: "toHomePage", sender: nil)
                }
            }
            
        }else {
            hataMesaji(titleInmup: "Hata", messageInput: "Email veya Şifre boş geçilemez!")
        }
    }
    
    
    
    /*@IBAction func btnKaydol(_ sender: Any) {
        performSegue(withIdentifier: "toKaydol", sender: nil)
        
        if txtEmail.text != "" && txtSifre.text != "" {
           ///firebase'e yeni kayıt lan kullanıcılalrı kaydeder.
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtSifre.text!) { AuthDataResult, Error in
                if Error != nil {
                    self.hataMesaji(titleInmup: "Hata", messageInput: Error?.localizedDescription ?? "Hata Aldınız.")
                }else{
                    self.performSegue(withIdentifier: "toHomePage", sender: nil)
                }
            }
        }
        else{
            hataMesaji(titleInmup: "Hata", messageInput: "Email veya Şifre boş geçilemez!")
        }
    }
    }*/
    
    
    func hataMesaji(titleInmup : String, messageInput : String) {
        let alert = UIAlertController(title: titleInmup, message: messageInput, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

