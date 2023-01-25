//
//  CountryCodeVC.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 25/01/23.
//

import UIKit

class CountryCodeVC: UIViewController {
    
    //MARK:  Outlets and Variable Declarations
    @IBOutlet weak var tblCountryCode: UITableView!
    
    private var arrOfCountryCode = [String]()
    var getSelectedOption: ((String) -> Void)?
    
    //MARK: 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK:  Buttons Clicked Actions
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:  Functions
    private func initialSetup() {
        
        self.arrOfCountryCode = contactManager.getCountryCodeList()
        self.tblCountryCode.reloadData()
    }
}

//MARK:  UISearchBarDelegate Methods
extension CountryCodeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.tblCountryCode.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

//MARK:  UITableViewDataSource Methods
extension CountryCodeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrOfCountryCode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCodeTableViewCell") as! CountryCodeTableViewCell
        
        cell.lblCountryCode.text = arrOfCountryCode[indexPath.row]
        
        return cell
    }
}

//MARK:  UITableViewDelegate Methods
extension CountryCodeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.getSelectedOption?(self.arrOfCountryCode[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
