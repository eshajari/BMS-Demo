//
//  ResultTableViewController.swift
//  BMS-Demo
//
//  Created by apple on 23/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

protocol ResultsTableViewDelegate: class {
  func didSelect(result: String)
}



class ResultTableViewController: UITableViewController {

    weak var delegate: ResultsTableViewDelegate?
    var isSearching :Bool!
    //var arrFilteredResult = [Result]()
    var arrFilteredResult = [Result]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var arrsearchHistory = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return isSearching ? ( arrFilteredResult.count) : ( arrsearchHistory.count)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if isSearching {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Moviecell", for: indexPath) as! Moviecell

            let objmv = arrFilteredResult[indexPath.row]
            cell.lblmoviename.text = objmv.title
            
            return cell

        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath)

            let lblname = cell.viewWithTag(10) as! UILabel
            lblname.text = arrsearchHistory[indexPath.row]
            
            return cell

        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching
        {
        
            let objmv = arrFilteredResult[indexPath.row]
            self.InsertSearchHistory(objmv.title)
        }
        else {
            let objstr = arrsearchHistory[indexPath.row]
            delegate?.didSelect(result: objstr)
            
        }
    }
    
    func InsertSearchHistory(_ textsearch: String) {
    
        if arrsearchHistory.count < 6 {
            arrsearchHistory.append(textsearch)
            
        }
        else {
            arrsearchHistory.removeFirst()
            arrsearchHistory.append(textsearch)
        }
        
        let defaults = UserDefaults.standard
        defaults.set(arrsearchHistory, forKey: EJTextConst.Key.local_store)
        defaults.synchronize()
    }
    
}
