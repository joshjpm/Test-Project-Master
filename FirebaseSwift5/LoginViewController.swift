//
//  ViewController.swift
//  FirebaseSwift5
//
//  Created by Wei Lian Chin on 26/08/2019.
//  Copyright © 2019 Wei Lian Chin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text! , password: password.text!){
            (user, error) in
            if error != nil {
                print (error!)
            }else {
                print("Login successful")
                self.performSegue(withIdentifier: "goHome", sender: self)
                
            }
        }
    }
    
    @IBAction func forceContinue(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goHome", sender: nil)
        
            let user = Auth.auth().currentUser
            if let user = user {
                
                let uid = user.uid
                let email = user.email
                
                print(uid)
                print(email)
            }
            
        }
    }
    
    
   
}

