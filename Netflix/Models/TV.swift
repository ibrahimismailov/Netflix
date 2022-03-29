//
//  TV.swift
//  Netflix
//
//  Created by Abraam on 29.03.2022.
//

import Foundation

struct MoviesTv: Codable {
    let results: [Tv]
   
}

struct Tv: Codable {
    let id: String
    let image: String
    let title: String

}
