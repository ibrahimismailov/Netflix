//
//  MovieListContract.swift
//  Netflix
//
//  Created by Abraam on 05.04.2022.
//

import Foundation
struct MovieListPresentation {
    let  id: String
    let  resultType: String
    let  image: String
    let  title: String
    let  description: String
}
protocol MovieListViewProtocol {
    func updateMovieList(_ : [MovieListPresentation])
}
