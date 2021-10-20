//
//  JsonData.swift
//  test_problem_onlym
//
//  Created by Khurshed Umarov on 20.10.2021.
//

import Foundation


struct OnlymJSON: Codable {
    let banners: [BannerJson]
    let articles: [ArticleJson]
}

struct ArticleJson: Codable {
    let title, text: String
}

struct BannerJson: Codable {
    let name, color: String
    let active: Bool
}
