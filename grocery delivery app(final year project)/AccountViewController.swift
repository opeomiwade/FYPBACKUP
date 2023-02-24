//
//  AccountViewController.swift
//  grocery delivery app(final year project)
//
//  Created by Ope Omiwade on 19/02/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore


var pointsEarned: Int = 0
var accountDetails : [String] = []
class AccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: IBOUTLETS, IBACTIONS AND VARIABLES
    @IBOutlet weak var accountImage: UIImageView!
    
    @IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    let accountList = ["Account Details", "Orders" , "Help" , "Log Out"]
    
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        accountImage.layer.cornerRadius = accountImage.frame.size.width / 2
    }
    
  
    //MARK: TABLE VIEW DATASOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return accountList.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AccountTableViewCell
        cell.label.text = accountList[indexPath.section]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(accountList[indexPath.section])
        if(accountList[indexPath.section] == "Help"){
        }
        
        else if(accountList[indexPath.section] == "Account Details"){
            performSegue(withIdentifier: "accounttodetails", sender: nil)
        }
        
        else if(accountList[indexPath.section] == "Orders"){
            performSegue(withIdentifier: "accounttoorders", sender: nil)
        }
    }
    
    //MARK: VIEWWILLAPPEAR
    override func viewWillAppear(_ animated: Bool) {
        let db = Firestore.firestore()
        db.collection("users").document(currentUserInfo["userId"] as! String).getDocument { document, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            else{
                currentUserInfo = document!.data()!
                print("document succesfully read")
            }
        }
        pointsEarned = currentUserInfo["points"] as! Int
        pointsLabel.text = "Points Earned: \(String(pointsEarned))"
    }
    

    
    
    
}
