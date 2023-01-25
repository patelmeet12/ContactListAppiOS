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
    
    private var arrOfContacts = [Contact]()
    private var arrOfContactsCopy = [Contact]()
    
    //MARK: 
    override func viewDidLoad() {
        super.viewDidLoad()

        getAllContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getContactFromCoreDatabase()
    }
    
    //MARK:  Buttons Clicked Actions
    @IBAction func btnAddClicked(_ sender: UIButton) {
        
        let addContactVC = storyboard?.instantiateViewController(withIdentifier: "AddContactVC") as! AddEditContactVC
        addContactVC.isFrom = .add
        self.navigationController?.pushViewController(addContactVC, animated: true)
    }
    
    //MARK:  Functions
    private func getAllContacts() {
        
        contactManager.fetchContacts(completion: { isSuccess, message, contacts in
            
            if isSuccess, let con = contacts {
            
                for c in con {
                    CoreDataManager.shared.insertContact(contact: c) { isSuccess, message in }
                }
                
                self.getContactFromCoreDatabase()
                
            } else {
                self.showAlertWithOkButton(message: message)
            }
        })
        
    }
    private func getContactFromCoreDatabase() {
        
        self.arrOfContacts = CoreDataManager.shared.getAllContacts()
        self.arrOfContactsCopy = self.arrOfContacts
        DispatchQueue.main.async {
            self.tblContactList.reloadData()
        }
    }
}

//MARK:  UISearchBarDelegate Methods
extension ContactListsVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            
            self.arrOfContactsCopy = self.arrOfContacts
        } else {
            
            self.arrOfContactsCopy = self.arrOfContacts.filter({$0.firstName.lowercased().contains(searchText.lowercased()) || $0.lastName.lowercased().contains(searchText.lowercased()) || $0.telephone.lowercased().contains(searchText.lowercased())})
        }
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
        
        return self.arrOfContactsCopy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTableViewCell") as! ContactListTableViewCell
        
        cell.configureCell(con: self.arrOfContactsCopy[indexPath.row])
        
        return cell
    }
}

//MARK:  UITableViewDelegate Methods
extension ContactListsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contactDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ContactDetailsVC") as! ContactDetailsVC
        contactDetailsVC.contact = self.arrOfContactsCopy[indexPath.row]
        self.navigationController?.pushViewController(contactDetailsVC, animated: true)
    }
}
