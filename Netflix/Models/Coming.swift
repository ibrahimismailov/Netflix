//
//  Coming.swift
//  Netflix
//
//  Created by Abraam on 29.03.2022.
//

import Foundation


import Foundation

// MARK: - Movies
struct Coming: Codable {
    let items: [ComeMovie]
    let errorMessage: String
}

// MARK: - Item
struct ComeMovie: Codable {
    let id, title, fullTitle, year: String
    let image: String
    let directors: String
    let stars: String
}


