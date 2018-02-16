//
//  SearchViewController.swift
//  GitHub Viewer
//
//  Created by João Leite on 15/02/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UITextFieldDelegate {

    var JSONMaster = [Dictionary<String, AnyObject>]()
    @IBOutlet weak var txtUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.delegate = self
        txtUsername.text = ""
        
    }

    @IBAction func btnSearch(_ sender: Any) {
        //Check if textfield has text
        if(txtUsername.text != ""){
            //Remove whitespaces that autocorrect can insert
            let username = txtUsername.text?.trimmingCharacters(in: .whitespaces)
            let URL = "https://api.github.com/users/\(username!)/repos"
            Alamofire.request(URL).responseJSON { response in
                if let JSON = response.result.value as? [Dictionary<String,AnyObject>] {
                    //GitHub returns an Array of Dictionaries if user is found.
                    //Prepare JSON result for segue
                    self.JSONMaster = JSON
                    self.performSegue(withIdentifier: "SearchToUserSegue", sender: self)
                    
                }else if (response.result.value as? Dictionary<String, AnyObject>) != nil {
                    //GitHub returns an Dictionary if user was not found.
                    let userNotFoundAlert = UIAlertController(title: "User not found",
                                                              message: "Please enter another name.",
                                                              preferredStyle: .alert)
                    
                    userNotFoundAlert.addAction(UIAlertAction(title: "OK",
                                                              style: .default,
                                                              handler: nil))
                    self.present(userNotFoundAlert, animated: true, completion: nil)
                    
                }else{
                    //Network Errors Alert
                    let networkErrorAlert = UIAlertController(title: "Error",
                                                              message: "A network error has occured. Check your Internet connection and try again later.",
                                                              preferredStyle: .alert)
                    
                    networkErrorAlert.addAction(UIAlertAction(title: "OK",
                                                              style: .default,
                                                              handler: nil))
                    
                    self.present(networkErrorAlert, animated: true, completion: nil)
                }
            }
        }else{
            //Textfield not populated alert
            let noUsernameAlert = UIAlertController(title: "Blank username",
                                                      message: "Please enter a username in the textfield",
                                                      preferredStyle: .alert)
            
            noUsernameAlert.addAction(UIAlertAction(title: "OK",
                                                      style: .default,
                                                      handler: nil))
            
            self.present(noUsernameAlert, animated: true, completion: nil)
        }
    }
    
    //Preparation for segue in order to send serialized JSON to UserProfileViewController without having to do another request.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userProfileView = segue.destination as! UserProfileViewController
        userProfileView.username = txtUsername.text!
        userProfileView.JSON = JSONMaster
    }
    
    //Functions to hide the keyboard
    //When user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //When user presses the "return" key
    func textFieldShouldReturn(_ txtUsername: UITextField) -> Bool{
        txtUsername.resignFirstResponder()
        return true
    }

    
}

