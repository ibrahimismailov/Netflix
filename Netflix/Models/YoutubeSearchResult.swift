//
//  YoutubeSearchResult.swift
//  Netflix
//
//  Created by Abraam on 04.05.2022.
//

import Foundation
struct YoutubeSearchResponse: Codable {
    let items: [VideoElements]
}
struct VideoElements: Codable {
    let id: IdVideoElement
}
struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
