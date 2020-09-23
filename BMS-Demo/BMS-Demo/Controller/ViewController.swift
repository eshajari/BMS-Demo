//
//  ViewController.swift
//  BMS-Demo
//
//  Created by ESHA PANCHOLI on 22/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage



class ViewController: UITableViewController  {
    
    

    var arrMovielist = [Result]()
    var cuPage = 1
    
    var searchController: UISearchController!
    var resultTblvc : ResultTableViewController!

    var arrlastsearch = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        //API call for all data display
        self.getAllNowplaying()
        
        //setup view and table
        setupDisplay()
    }
    
    func setupDisplay(){
        
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: EJTextConst.Key.local_store) as? [String] ?? [String]()

        
        resultTblvc = storyboard!.instantiateViewController(withIdentifier: "IDResultTableViewController") as? ResultTableViewController
        resultTblvc.delegate = self
        
        searchController = UISearchController(searchResultsController: resultTblvc)
        navigationItem.searchController = searchController
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a movie"
        //searchController.searchBar.scopeButtonTitles = Year.allCases.map { $0.description }
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        //searchController.automaticallyShowsScopeBar = false
        searchController.searchBar.searchTextField.textColor = .systemRed
        searchController.searchBar.searchTextField.tokenBackgroundColor = .systemRed
        
        resultTblvc.isSearching = false
        resultTblvc.arrsearchHistory = savedArray
        
        
    }
    
    //MARK: - Table view methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMovielist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Moviecell") as! Moviecell
   
        let objMovie = arrMovielist[indexPath.row]
        
        cell.lblmoviename.text = objMovie.title
        cell.lbldesc.text = objMovie.overview
        cell.lblreleasedate.text = objMovie.releaseDate
        let imgurl = URL(string: "\(EJTextConst.APIURL.API_ImageBase)\(objMovie.posterPath ?? "")")
        cell.imgposter.sd_setImage(with: imgurl, placeholderImage: UIImage.init(named: "placeholder_poster"))
        cell.btnbook.addTarget(self, action: #selector(btnBookclicked(_:)), for: .touchUpInside)
        cell.btnbook.layer.cornerRadius = 4.0
        cell.btnbook.layer.masksToBounds = true
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objMovie = arrMovielist[indexPath.row]
               
        self.InsertSearchHistory(objMovie.title)
        
        let vc =  storyboard!.instantiateViewController(withIdentifier: "IDDetailViewController") as! DetailViewController
        vc.cuMovieId = objMovie.id
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnBookclicked(_ sender : UIButton){
        showAlertonly(controller: self, withMessage: "Feature coming soon!")
    }
    
    
    

}

//MARK: - Search delegate
extension ViewController : UISearchResultsUpdating , ResultsTableViewDelegate {
    
    func didSelect(result: String) {
        
        searchController.searchBar.searchTextField.text = result
        searchforText(result)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
            
        if searchController.searchBar.searchTextField.isFirstResponder {
          searchController.showsSearchResultsController = true
          // 2
          //searchController.searchBar.searchTextField.backgroundColor = UIColor.rwGreen().withAlphaComponent(0.1)
        } else {
          // 3
          searchController.searchBar.searchTextField.backgroundColor = nil
        }
        
        if searchController.searchBar.text!.count < 1 {
            resultTblvc.isSearching = false
            resultTblvc.tableView.reloadData()
        }
        else {
            resultTblvc.isSearching = true
        }
        
       
        
    }
    
    func InsertSearchHistory(_ textsearch: String) {
        
        if resultTblvc.arrsearchHistory.count < 6 {
            resultTblvc.arrsearchHistory.append(textsearch)
            
        }
        else {
            resultTblvc.arrsearchHistory.removeFirst()
            resultTblvc.arrsearchHistory.append(textsearch)
        }
        let defaults = UserDefaults.standard
        defaults.set(resultTblvc.arrsearchHistory, forKey: EJTextConst.Key.local_store)
        defaults.synchronize()
    }
}

extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        print("Serching with \(searchText)")
        if searchController.searchBar.text!.count > 0 {
            searchforText(searchText)
        }
    
    }
    
    
    
    func searchforText(_ searchtxt : String?){
        
        //Init searchcnt
        guard searchController.isActive else { return }
        
        //Local text
        guard let searchtxt = searchtxt else {
          resultTblvc.arrFilteredResult = [Result]()
          return
        }
        
        // check basic nil
        if searchtxt.isEmpty {
            return
        }
        
        //Filter with predicating result
        let filterlocal = arrMovielist.filter{  objMv -> Bool in
           
            //let predi = NSPredicate.init(format: "title CONTAINS[c] %@*", searchtxt)
            
            let name = objMv.title
            if name.contains(searchtxt) {
                let range = name.range(of: searchtxt) //as Range
                let position = range?.lowerBound.utf16Offset(in: name)
                if position != 0 {
                    let prevElement = name[name.index(before: range!.lowerBound)]
                    if prevElement == " " {
                        return true }
                    else{
                        return false
                    }
                }
                else {
                    return true
                }
                
                //return true
            }
            else{
                return false
            }
        }
        
        resultTblvc.arrFilteredResult = filterlocal
        print("Filted data: \(filterlocal)")
        searchController.reloadInputViews()
        searchController.showsSearchResultsController = true
        
    }
    
    
}

// API
extension ViewController {
    
    func getAllNowplaying(){
        
        showProgressHUD()
        
        let urlnowplay = "\(EJTextConst.APIURL.API_BaseHook)\(EJTextConst.API_Path.API_nowplaying)?api_key=\(EJTextConst.Key.API_KEY_MDB)&language=en-US&page=\(cuPage)"

        let apiRequest = AF.request(urlnowplay)

        apiRequest.validate(statusCode: 200..<300).responseDecodable(of: NowPlaying.self){ (response) in

            if response.response?.statusCode == 200 {

                guard let nowfilms = response.value else { return }

                print("all films: \(nowfilms)")
                
                self.arrMovielist.append(contentsOf: nowfilms.results)
                DispatchQueue.main.async {
                    self.hideProgressHUD()
                    self.tableView.reloadData()
                }

            }
            else if response.response?.statusCode == 401 {
                self.showAlertonly(controller: self, withMessage: EJTextConst.Messages.keyauthError)
            }
            else if response.response?.statusCode == 404{
                self.showAlertonly(controller: self, withMessage: EJTextConst.Messages.urlError)
            }
            else {

            }


        }
        
    }
    
    

//
//
////    func APIReqCall(apiRequest : DataRequest , completion: @escaping ((_ issucceed: Bool,_ errmsg: String?,_ resp: Any?)->Void)){
//    func APICall(){
//        let urlnowplay = "\(EJTextConst.APIURL.API_BaseHook)\(EJTextConst.API_Path.API_nowplaying)?api_key=\(EJTextConst.Key.API_KEY_MDB)&language=en-US&page=\(cuPage)"
//
//        let apiRequest = AF.request(urlnowplay)
//
//        apiRequest.validate().responseJSON { (response) in
//
//            switch response.result {
//            case .failure:
//                if let stacode = response.response?.statusCode {
//                    var errmsg = ""
//                    let json = try? (JSONSerialization.jsonObject(with: (response.data)!, options: []) as! [String: String])
//
//                        if stacode == 401 {
//                            errmsg = json!["status_message"]!
//                        }
//                        if stacode == 404 {
//                            errmsg = json!["status_message"]!
//                        }
//                        //completion(false,errmsg,nil)
//                    }
//
//                break
//
//            case .success(let val):
//                //completion(false,nil,val)
//                print("issucceed\(val)")
//                break
//            }
//        }
//    }
    
    
}
