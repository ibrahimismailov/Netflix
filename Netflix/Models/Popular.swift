//
//  Popular.swift
//  Netflix
//
//  Created by Abraam on 29.03.2022.
//

import Foundation
struct MoviesPop: Codable {
    let items: [Pop]
    let errorMessage: String
}

// MARK: - Item
struct Pop: Codable {
    let id, rank, rankUpDown, title: String
    let fullTitle, year: String
    let image: String



}
