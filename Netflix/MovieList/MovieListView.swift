//
//  MovieListView.swift
//  Netflix
//
//  Created by Abraam on 05.04.2022.
//

import UIKit
final class MovieListView: UIView {
    private var movieList: [MovieListPresentation] = []
    private let tableView = UITableView()
}
extension MovieListView: MovieListViewProtocol {
    func updateMovieList(_ movielist: [MovieListPresentation]) {
        self.movieList = movielist
       tableView.reloadData()
    }
}
extension MovieListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
        let movie = movieList[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    }

extension MovieListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO
    }
}
