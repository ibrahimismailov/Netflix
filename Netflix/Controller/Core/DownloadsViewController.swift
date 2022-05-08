//
//  DownloadsViewController.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//

import UIKit

class DownloadsViewController: UIViewController {
    private var titles: [TitleItem] = [TitleItem]()
    private let downloadedTable: UITableView = {
        let tableView  = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .gray
        view.addSubview(downloadedTable)
        downloadedTable.dataSource = self
        downloadedTable.delegate = self
        fetchLocalStorgeforDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorgeforDownload()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
    private func fetchLocalStorgeforDownload() {
        DataPersistenceManager.shared.fetchFromDatabase {[weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension  DownloadsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else{
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModelPresentation(image: title.image ?? "" , title: title.title ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
           
            DataPersistenceManager.shared.deleteItemWith(model: titles[indexPath.row]) {[weak self] result in
                switch result {
                case.success():
                    print("Deleted Form tableView")
                case.failure(let error):
                    print(error.localizedDescription)
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
             
            }
        default:
            break ;
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        
        APICaller.shared.getMovies(with: title.title ?? "") { result in
            switch result {
            case.success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: title.title ?? "", youtubeView: videoElement, titleOverView: title.resultType ?? ""))
                    self.navigationController?.pushViewController(vc, animated: true)
                }
   
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
      
                
        
    }
}
