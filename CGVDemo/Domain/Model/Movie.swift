//
//  Movie.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id, sku, category, name: String?
    let thumbnail: String?
    let url: String?
    let fullDescription, genre, ratingCode: String?
    let ratingIcon: String?
    let reviewPercent, codes, releaseDate: String?
    let movieTrailer: String?
    let movieDirector, movieLanguage: String?
    let movieEndtime: Int?
    let movieActress: String?
    let isBooking, isSneakshow, isNew, isGerp: Bool?
    let categoryID: Int?
    let movieEvent: String?
    let position: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, sku, category, name, thumbnail, url
        case fullDescription = "full_description"
        case genre
        case ratingCode = "rating_code"
        case ratingIcon = "rating_icon"
        case reviewPercent = "review_percent"
        case codes
        case releaseDate = "release_date"
        case movieTrailer = "movie_trailer"
        case movieDirector = "movie_director"
        case movieLanguage = "movie_language"
        case movieEndtime = "movie_endtime"
        case movieActress = "movie_actress"
        case isBooking = "is_booking"
        case categoryID = "category_id"
        case movieEvent = "movie_event"
        case isSneakshow = "is_sneakshow"
        case isNew = "is_new"
        case position = "position"
        case isGerp = "is_gerp"
    }
    
    func getReleaseDateString() -> String? {
        if let dateStr = self.releaseDate, let date = dateStr.convertToDate(format: "yyyy-MM-dd hh:mm:ss"), let dateStringFormated = date.convertToString(format: "dd MMM, yyyy") {
            return dateStringFormated
        }
        return nil
    }
    
    func getRatedString() -> String? {
        if let ratingCode = self.ratingCode, let rate = Rate(rawValue: ratingCode) {
            return rate.contentString
        }
        return nil
    }
}

