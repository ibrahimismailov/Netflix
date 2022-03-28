//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

static let identifier = "CollectionViewTableViewCell"
    private let collectioView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectioView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .gray
        return cell
    
    
}
}
