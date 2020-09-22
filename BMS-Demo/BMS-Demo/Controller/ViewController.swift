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

class ViewController: UITableViewController , UISearchResultsUpdating, UISearchBarDelegate {
    
    

    var arrMovielist = [Result]()
    var cuPage = 1
    
    var searchController: UISearchController!
    var resultTblvc : ResultTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //API call for all data display
        self.getAllNowplaying()
        
        //setup view and table
        setupDisplay()
    }
    
    func setupDisplay(){
        
        
        resultTblvc = storyboard!.instantiateViewController(withIdentifier: "IDResultTableViewController") as? ResultTableViewController
        //resultTblvc.delegate = self
        
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
        cell.imgposter.sd_setImage(with: imgurl, placeholderImage: UIImage.init(named: ""))
        cell.btnbook.addTarget(self, action: #selector(btnBookclicked(_:)), for: .touchUpInside)
               
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    @objc func btnBookclicked(_ sender : UIButton){
        showAlertonly(controller: self, withMessage: "Feature coming soon!")
    }
    
    //MARK: - Search delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        
    }
    

}


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
