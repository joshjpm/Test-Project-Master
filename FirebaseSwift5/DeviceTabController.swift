//
//  HomeViewController.swift
//  FirebaseSwift5
//
//  Created by Wei Lian Chin on 27/08/2019.
//  Copyright © 2019 Wei Lian Chin. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DeviceTabController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
//    var id_list = [String]()
//    var name_list = [String]()
//    var user_list = [String]()
    
    var refresh = 1
    //sample data
    var id_list = ["1","2","3","1","2","3","1","2","3"]
    var name_list = ["dog","cat","cow","1","2","3","1","2","3"]
    var user_list = ["richard", "john", "Ian","1","2","3","1","2","3"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        db.collection("devices").getDocuments{(snapshot,error)in
            if error != nil {
                print (error!)
            }else {
                for document in (snapshot?.documents)!{
                    if let id = document.data()["Id"] as? String {
                        self.id_list.append(id)

                    }
                }
                for document in (snapshot?.documents)!{
                    if let name = document.data()["Name"] as? String {
                        self.name_list.append(name)

                    }
                }
                for document in (snapshot?.documents)!{
                    if let user = document.data()["User"] as? String {
                        self.user_list.append(user)

                    }
                }

            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Devices"
    }
    
    @IBAction func refreshButtonTouch(_ sender: Any) {
        print(id_list)
        print(user_list.count)
        refresh = 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.navigationItem.setHidesBackButton(true, animated:true);
        return id_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! CollectionViewCell
        cell.id.text = id_list[indexPath.row]
        cell.name.text = name_list[indexPath.row]
        cell.user.text = user_list[indexPath.row]
        
        
        // MARK: - Cell Styling
        
        //if want image "cell.xx.image = xx[indexPath.row]
//        cell.contentView.layer.cornerRadius = 10
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = false
//        cell.layer.shadowColor = UIColor.gray.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        cell.layer.shadowRadius = 4.0
//        cell.layer.shadowOpacity = 1.0
//        cell.layer.masksToBounds = false
//        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        cell.contentView.backgroundColor = .white
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = cell.contentView.layer.cornerRadius
        
        
        return cell
    }
    
    @IBAction func logOutButtonTouch(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
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
