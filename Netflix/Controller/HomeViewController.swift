//
//  HomeViewController.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//
enum Section: Int {
    case tradingMovies = 0
    case tradingTV = 1
    case popular = 2
    case coming = 3
  
}
import UIKit
class HomeViewController: UIViewController {
  
    let sectionTitles: [String] = ["Trending Movies","Trending TV","Popular","UpComing Movies"]
    private let homeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTableView)
        homeFeedTableView.delegate = self
        homeFeedTableView.dataSource = self
        concigureHeaderView()
        configureNavBar()
    }


    private func configureNavBar(){
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func concigureHeaderView(){
        let headerView = HeroHeaderUIview(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        homeFeedTableView.tableHeaderView = headerView
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
            
        case Section.tradingMovies.rawValue:
            APICaller.shared.getTradingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let errors):
                    print(errors.localizedDescription)
                }
            }
        case Section.tradingTV.rawValue:
            APICaller.shared.getTradingTv { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let errors):
                    print(errors.localizedDescription)
                }
            }
        case Section.popular.rawValue:
            APICaller.shared.getPopular { result in
                switch result{
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let errors):
                    print(errors.localizedDescription)
                }
            }
        case Section.coming.rawValue:
            APICaller.shared.getComing { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let errors):
                    print(errors.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{ return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor =  .white
        header.textLabel?.text = header.textLabel?.text?.capitalFirstLatter()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOfSet = view.safeAreaInsets.top
        let offSet = scrollView.contentOffset.y + defaultOfSet
        navigationController?.navigationBar.transform  = .init(translationX: 0, y: min(0, -offSet))
    }
    
}
