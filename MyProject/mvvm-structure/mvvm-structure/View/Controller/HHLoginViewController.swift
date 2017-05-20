//
//  HHLoginViewController.swift
//  FireNotes
//
//  Created by Hieu Huynh on 5/20/17.
//  Copyright © 2017 Fraternal Group Pte. Ltd. All rights reserved.
//

import UIKit
import FirebaseAuth

class HHLoginViewController: UIViewController {
    // MARK: Constants
    let loginToList = "LoginToList"
    // MARK: - Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    // MARK: - Actions
    /// Show sign up popup
    @IBAction func signUpPressed() {
        let alert = createSignUpAlert()
        // present alert
        present(alert, animated: true, completion: nil)
    }
    @IBAction func loginPressed() {
//        performSegue(withIdentifier: loginToList, sender: nil)

        // perform login
        //FIRAuth.auth()!.signIn(withEmail: emailField.text!,
         //                      password: passwordField.text!)
    }
    // MARK: - Overriden 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - fileprivate methods    
    /// Call Firebase API to sign up a new user
    ///
    /// - Parameters:
    ///   - email: email
    ///   - password: password
    fileprivate func signupUser(email: String, password: String) {
        FIRAuth.auth()!.createUser(
            withEmail: email,
            password: password) { _, error in
                if error == nil {
                    UIAlertController.showAlert(withTitle: "Congrats!",message: "Your account was created", from: self)
                } else {
                    UIAlertController.showAlert(message: error?.localizedDescription, from: self)
                }
        }
        
    }

    /// Creates a sign up alert controller
    ///
    /// - Returns: a sign up alert controller
    fileprivate func createSignUpAlert() -> UIAlertController {
        // init alert
        let alert = UIAlertController(title: "Sign up",
                                      message: nil,
                                      preferredStyle: .alert)
        // setup sign up action
        let signUpAction = UIAlertAction(
            title: "Sign up",
            style: .default) {[weak self] _ in
                guard let email = alert.textFields?[0].text else {return}
                guard let password = alert.textFields?[1].text else {return}
                self?.signupUser(email: email, password: password)
        }
        // setup cancel action
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        // add text fields to alert
        alert.addTextField { emailField in
            emailField.placeholder = "Enter your email"
        }
        alert.addTextField { passwordField in
            passwordField.isSecureTextEntry = true
            passwordField.placeholder = "Enter your password"
        }
        // add actions to alert
        alert.addAction(signUpAction)
        alert.addAction(cancelAction)
        return alert
    }

}
