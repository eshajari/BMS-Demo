//
//  DetailViewController.swift
//  BMS-Demo
//
//  Created by apple on 23/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    var cuMovieId = 0
    
    
    @IBOutlet weak var imgbackdrop: UIImageView!
    
    @IBOutlet weak var lblmoviename: UILabel!
    @IBOutlet weak var lbllikecount: UILabel!
    @IBOutlet weak var lblTagline: UILabel!
    @IBOutlet weak var lblReleasedate: UILabel!
    @IBOutlet weak var lbldesc: UILabel!
    
    
    @IBOutlet weak var collreview: UICollectionView!
    @IBOutlet weak var collcasts: UICollectionView!
    @IBOutlet weak var collcrew: UICollectionView!
    @IBOutlet weak var collsimilar: UICollectionView!
    
    var midselected : String!
    var cuMovieObj : MovieDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getmoviedetails()
    }
    
    func setupUIDetails(){
        
        let imgurl = URL(string: "\(EJTextConst.APIURL.API_ImageBase)\(cuMovieObj.backdropPath ?? "")")
        self.imgbackdrop.sd_setImage(with: imgurl)
        
        self.lblmoviename.text = cuMovieObj.title
        self.lblTagline.text  = cuMovieObj.tagline
        self.lblReleasedate.text = "Released on: \(cuMovieObj.releaseDate)"
        self.lbllikecount.text = String(cuMovieObj.voteCount)
        self.lbldesc.text = cuMovieObj.overview
    }
    
    func getmoviedetails(){
        
        DispatchQueue.global().async {
            
            self.API_synop()
            self.API_reviews()
            self.API_Credits()
            self.API_suggetions()
        }
    }

    func API_synop(){
        
        showProgressHUD()
        
        let urlapi = "\(EJTextConst.APIURL.API_BaseHook)\(EJTextConst.API_Path.API_synops)?api_key=\(EJTextConst.Key.API_KEY_MDB)&language=en-US"
        let finalURL = urlapi.replacingOccurrences(of: EJTextConst.Key.mID_dyn, with: "\(cuMovieId)")

        let apiRequest = AF.request(finalURL)

        apiRequest.validate(statusCode: 200..<300).responseDecodable(of: MovieDetail.self){ (response) in

            if response.response?.statusCode == 200 {

                guard let details = response.value else { return }

                print("all details: \(details)")
                self.cuMovieObj = details
                DispatchQueue.main.async {
                    self.setupUIDetails()
                    self.hideProgressHUD()
                }

            }
            else if response.response?.statusCode == 401 {
                self.showAlertonly(controller: self, withMessage: EJTextConst.Messages.keyauthError)
                self.hideProgressHUD()
            }
            else if response.response?.statusCode == 404{
                self.showAlertonly(controller: self, withMessage: EJTextConst.Messages.urlError)
                self.hideProgressHUD()
            }
            else {
                self.hideProgressHUD()
            }


        }
        
    }
    
    func API_reviews(){
        
    }
    
    func API_Credits(){
        
    }
    
    func API_suggetions(){
        
    }
   

}

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
              
    }
    
    
}
