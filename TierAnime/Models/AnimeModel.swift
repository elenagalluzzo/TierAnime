//
//  AnimeModel.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-01.
//

import Foundation

struct AnimeModel: Codable {
    let data: [Data]
}

struct Data: Codable {
    let title: String
    let genres: [String]?
    let episodes: Int
    let image: String
    let synopsis: String
    let rating: Int?
}
