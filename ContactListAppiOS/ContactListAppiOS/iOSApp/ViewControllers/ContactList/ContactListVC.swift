//
//  ContactListVC.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 23/01/23.
//

import UIKit

class ContactListsVC: UIViewController {
    
    //MARK:  Outlets and Variable Declarations
    @IBOutlet weak var tblContactList: UITableView!
    
    //MARK: 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK:  Buttons Clicked Actions
    @IBAction func btnAddClicked(_ sender: UIButton) {
        
        let addContactVC = storyboard?.instantiateViewController(withIdentifier: "AddContactVC") as! AddContactVC
        self.navigationController?.pushViewController(addContactVC, animated: true)
    }
    
    //MARK:  Functions
}

//MARK:  UISearchBarDelegate Methods
extension ContactListsVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.tblContactList.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

//MARK:  UITableViewDataSource Methods
extension ContactListsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTableViewCell") as! ContactListTableViewCell
        
        return cell
    }
}

//MARK:  UITableViewDelegate Methods
extension ContactListsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
