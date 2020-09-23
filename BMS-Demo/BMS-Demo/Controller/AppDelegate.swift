//
//  AppDelegate.swift
//  BMS-Demo
//
//  Created by ESHA PANCHOLI on 22/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
//        let eshaname = "hello world"
//        let swrd = "world"
//        if eshaname.contains("world") {
//            print("yes world is there")
//        }
//
//        if eshaname.contains(swrd) {
//            print("yes world is there too")
//        }
//
//        let search = "Ralph"
//        let search2 = "Rapsody"
//        let moviename = "Ralph Breaks The Internet"
//        let moviename2 = "Bohemian Rapsody"
//
//        if moviename.contains(search) {
//            print("yes movie has rapsody")
//
//            let range = moviename.range(of: search) //as Range
//            let prevelement = moviename[range!.lowerBound]
//            print("prev: \(prevelement)")
//
//            let position = range?.lowerBound.utf16Offset(in: moviename)
//            print("lower : \(position ?? 10)")
//            //let baseIdx = moviename.index(before: range!.lowerBound)
//
//            let prevelement2 = moviename[moviename.index(before: range!.lowerBound)]
//            print("prev2: \(prevelement2)")
//        }

//        if moviename2.contains(search2) {
//            print("yes movie has rapsody toooo")
//        }
//
//        let name = moviename2
//
//        var idx = 0
//        for  char in moviename2 {
//
//            if search2.first == char {
//                let fIndx = moviename2.firstIndex(of: char)
//
//                let startR = moviename2.index(moviename2.startIndex, offsetBy: idx)
//                let lenR = moviename2.index(moviename2.startIndex, offsetBy: search2.count+idx)
//                let range = startR..<lenR
//
//                let issame = String(moviename2[startR..<lenR]) == search2
//                print("is same: \(issame)")
//
//                let newstr = moviename2[startR..<lenR].uppercased()
//                if moviename2[startR..<lenR] == search2 {
//                    print("Found!")
//                    break
//                }
//
//                if String(moviename2[startR..<lenR]).uppercased().elementsEqual(search2.uppercased()) {
//                    print("Found in other!")
//                    break
//                }
//
////                if moviename2.substring(with: range) == name {
////                    print("Found!")
////                    break
////                }
//            }
//            idx += 1
//        }
        
//
//        if moviename2.contains(search) {
//            print("found \(search) in \(name)")
//        }
//        let range2 = name.range(of: search) //as Range
//        if name.contains(search) {
//
//            let range = name.range(of: search) //as Range
//
//            let prevElement = name[range!.lowerBound]
//            print(prevElement)
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

