//
//  ComingViewController.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//

import UIKit

class ComingViewController: UIViewController {
    private var titles:[Title] = [Title]()
   
    private let upcomingTable: UITableView = {
        let tableView  = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UpComing"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        fetchUpComing()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    private func fetchUpComing(){
        APICaller.shared.getPopular { [weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
               
            case.failure(let errors):
                print(errors.localizedDescription)
            }
        }
    }
}
extension ComingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else{
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModelPresentation(image: title.image , title: title.title))
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
