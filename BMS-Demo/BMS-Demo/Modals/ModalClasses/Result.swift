//
//  Result.swift
//  BMS-Demo
//
//  Created by ESHA PANCHOLI on 22/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Result
struct Result: Codable {
    let posterPath: String?
    let adult: Bool
    let overview, releaseDate: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let originalLanguage: String
    let title, backdropPath: String
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case sv = "sv"
}
