//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//

import UIKit
import CoreData
protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}
class CollectionViewTableViewCell: UITableViewCell {
    private var titles:[Title] = [Title]()
    var viewModel:  TitlePreviewViewModel?
    weak var delegate: CollectionViewTableViewCellDelegate?
static let identifier = "CollectionViewTableViewCell"
    private let collectioView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectioView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectioView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectioView)
        
        collectioView.delegate = self
        collectioView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectioView.frame = contentView.bounds
    }
    public func configure(with title: [Title]) {
        self.titles = title
        DispatchQueue.main.async { [weak self] in
            self?.collectioView.reloadData()
        }
    }
    private func downloadAt(index: IndexPath)  {
        DataPersistenceManager.shared.downloadTitleWith(model: titles[index.row]) { result in
            switch result {
            case.success():
                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"),object: nil)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
       
        
    }
    
}
  
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
       
        cell.configure(with: titles[indexPath.row].image)
        return cell
}
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
      
        let title = titles[indexPath.row]
        let titleName = title.title
        APICaller.shared.getMovies(with: titleName + "trailer") {[weak self] result in
            switch result {
            case.success(let videoElement):
                let overView = self?.viewModel?.titleOverView
               
                guard let strongSelf = self else {return}
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverView:overView ?? "" )
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel )
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil) { [weak self] _ in
            let downloadAction = UIAction(title: "Download",
                                          subtitle: nil,
                                          image: nil,
                                          identifier: nil,
                                          discoverabilityTitle: nil,
                                          state: .off) { _ in
                self?.downloadAt(index: indexPath)
            }
            return UIMenu(title: "",
                          image: nil,
                          identifier: nil,
                          options: .displayInline,
                          children: [downloadAction])
        }
        return config
    }
}
