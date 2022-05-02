//
//  TitleCollectionViewCell.swift
//  Netflix
//
//  Created by Abraam on 29.03.2022.
//

import UIKit
import SDWebImage
class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionViewCell"
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview( postImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
        
    }
    
    public func configure(with model: String){
        guard let url = URL(string: model) else { return }
        postImageView.sd_setImage(with: url,completed: nil)
        print(model)
        
    }
}
