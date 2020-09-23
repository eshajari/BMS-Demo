//
//  EJTextConst.swift
//  EcommApp
//
//  Created by ESHA PANCHOLI on 18/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation

struct EJTextConst
{
    struct Label
    {
        static let Ok          = "OK"
        static let Done        = "Done"
        static let Cancel      = "Cancel"
       
    }
    
    struct Key
    {
        static let appName     = "BMS-Demo"
        static let appLanguage = "en"
        static let appMessages = "appmessages"
        static let API_KEY_MDB = "bf0ae4e3f08d644953d8ebc80aa6639b"
        
        static let local_store = "localstorageDB"
        
        static let mID_dyn = "{movie_id}"
    }
    
    
    struct Messages {
        
        static let connectionError = "Network connection is not available."
        static let keyauthError = "Invalid API key: You must be granted a valid key."
        static let urlError = "The resource you requested could not be found."
        
        
    }
    
    struct APIURL {
        
        static let API_BaseHook = "https://api.themoviedb.org/3/"
        static let API_ImageBase = "https://image.tmdb.org/t/p/original"
        
    }
    
    struct API_Path {
        
        static let API_nowplaying = "movie/now_playing"
        static let API_synops = "movie/{movie_id}"
        static let API_review = "movie/{movie_id}/reviews"
        static let API_credits = "movie/{movie_id}/credits"
        static let API_similar = "movie/{movie_id}/similar"
        
    }
    
    struct ViewCnt {
        static let SIDMain = "Main"
        
        
        static let VidHome = "IDHomeViewController"
        static let VidDetail = "IDDetailViewController"
        static let VidProductList = "IDProductListController"
        static let VidProduct = "IDProductViewController"
    }
}
