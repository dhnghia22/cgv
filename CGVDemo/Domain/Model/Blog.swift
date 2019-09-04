//
//  Blog.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

struct Blog: Codable {
    let id, title: String?
    let thumbnail: String?
    let content: String?
    let shortDescription: String?
    let url: String?
    let images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail, content, url, images
        case shortDescription = "short_description"
    }
}

