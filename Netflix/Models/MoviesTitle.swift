//
//  Movies.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//

import Foundation
import UIKit
struct TitleResponse:Decodable {
    var searchType:String
    var expression:String
    var results:[Title]
}
struct Title:Decodable {
    var id:String
    var resultType:String
    var image:String
    var title:String
    var description:String
}
struct ErrorMessage {
    var errorMessage:String
}

