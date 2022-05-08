//
//  SearchViewController.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//

import UIKit

class SearchViewController: UIViewController {
    private var titles: [Title] = [Title]()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .cyan
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        fetchSearchMovies()
        searchController.searchResultsUpdater = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
       
        
    }
    func fetchSearchMovies() {
        APICaller.shared.getSearchMovies {[ weak self ] (result) in
            switch result {
            case.success(let title):
                self?.titles = title
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let image = title.image
        let tit = title.title
        let model = TitleViewModelPresentation(image: image, title: tit)
        cell.configure(with: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        APICaller.shared.getMovies(with: title.title) { result in
            switch result {
            case.success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: title.title, youtubeView: videoElement, titleOverView: title.resultType))
                    self.navigationController?.pushViewController(vc, animated: true)
                }
   
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
      
                
        
    }
}
extension SearchViewController: UISearchResultsUpdating, SearchResultViewControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
                !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
                let resultController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        resultController.delegate = self
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let titles):
                    resultController.titles = titles
                    resultController.searchResultsCollectionView.reloadData()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
 
    }
}
