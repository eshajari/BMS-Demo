//
//  NowPlaying.swift
//  BMS-Demo
//
//  Created by ESHA PANCHOLI on 22/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation

struct NowPlaying: Codable {
    let page: Int
    let results: [Result]
    let dates: Dates
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}
