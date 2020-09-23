//
//  DetailViewController.swift
//  BMS-Demo
//
//  Created by apple on 23/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var cuMovieId = 0
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
    }
    
    func API_reviews(){
        
    }
    
    func API_Credits(){
        
    }
    
    func API_suggetions(){
        
    }
   

}

//extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return nil
//    }
//    
//    
//}
