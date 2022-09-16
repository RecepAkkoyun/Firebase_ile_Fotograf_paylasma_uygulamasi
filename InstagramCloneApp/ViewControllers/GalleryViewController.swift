//
//  GalleryViewController.swift
//  InstagramCloneApp
//
//  Created by Recep Akkoyun on 13.09.2022.
//

import UIKit
import Firebase
import FirebaseStorage /// Storage işlemleri için immport edilmeli

class GalleryViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var lblPaylas: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtYorum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imageView.isUserInteractionEnabled = true
        let gorselGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gorselGestureRecognizer)
        lblPaylas.isEnabled = false
    }
    
    @objc func gorselSec() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true , completion: nil)
        lblPaylas.isEnabled = true
    }
    
    @IBAction func btnPaylas(_ sender: Any) {
        lblPaylas.isEnabled = false
        //Fotografi firabase'e kaydetme işlemleri:
        let storage = Storage.storage()
        
       ///Şimdi nerden referans alıcağını (nereye yüklüceğini) belirtiyoruz
        let storageReference = storage.reference()
        
        ///Şimdi firebase'e bi dosya oluşturcam, bu dosya benim referansım olucak
        let mediaFolder = storageReference.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5)
        {
            /// fotograflari id olarak kaydedicem, isim çakışması olmaması için.
            let uuid = UUID().uuidString
            
        ///Şimdi aldığım datayı oluşturduğum media klasörü altına eklicem.
        let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (storagemetadata, error)in
                if error != nil {
                    self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Hata Aldınız")
                }else {
                    imageReference.downloadURL{ (url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            //Veri Kaydetme Islemleri
                            
                            if let imageUrl = imageUrl {
                            let fireStoreDatabase = Firestore.firestore()
                                ///sözlük oluşturucam
                                let fireStorePost = [
                                    "gorselId" : imageUrl,
                                    "yorum" :self.txtYorum.text!,
                                    "email" : Auth.auth().currentUser?.email,
                                    "tarih" : FieldValue.serverTimestamp()
                                ] as [String : Any]
                            ///firebase'e post adında bir referans oluşturuyoruz.
                                fireStoreDatabase.collection("Post").addDocument(data: fireStorePost) { (error) in
                                    if error != nil {
                                        self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Hata")
                                    }else{
                                        self.imageView.image = UIImage(named: "upload")
                                        self.txtYorum.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                        
                                    }
                                }
                                
                                
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    func hataMesaji(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
