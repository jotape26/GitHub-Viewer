//
//  UserProfileViewController.swift
//  AgileContentCodingTest
//
//  Created by João Leite on 15/02/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var JSON = [Dictionary<String, AnyObject>]()
    var username = String()
    var noRepositories = false
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var tblRepositories: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width / 2
        self.imgProfile.clipsToBounds = true
        loadProfileImage()
        lblUsername.text = username
        tblRepositories.delegate = self
        tblRepositories.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (JSON.count > 0){
            return JSON.count
        }else{
            noRepositories = true
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(noRepositories != true){
            let cell = tblRepositories.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryTableViewCell
            
            cell.lblRepositoryName.text = JSON[indexPath.row]["name"] as? String
            cell.lblRepositoryLanguage.text = JSON[indexPath.row]["language"] as? String
            
            return cell
        }else{
            let cell = tblRepositories.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryTableViewCell
            
            cell.lblRepositoryName.text = ""
            cell.lblRepositoryLanguage.text = "User doesn't have any public repositories"
            return cell
        }
    }

    func loadProfileImage(){
        if (JSON.count > 0){
            let owner = JSON[0]["owner"]
            let URL = "\(String(describing: owner!["avatar_url"]!!)).jpg"
            Alamofire.request(URL).responseImage { response in
                guard let image = response.result.value else { return }
                self.imgProfile.image = image
            }
        }
    }
}
