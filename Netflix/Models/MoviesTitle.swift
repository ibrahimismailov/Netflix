//
//  Movies.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//

import Foundation
import UIKit


// MARK: - TitleResponse
struct TitleResponse: Codable {
    let searchType, expression: String
    let results: [Title]
    let errorMessage: String
}

// MARK: - Title
struct Title: Codable {
    let id, resultType: String
    let image: String
    let title, resultDescription: String

    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case resultDescription = "description"
    }
}





