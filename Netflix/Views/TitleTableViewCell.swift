//
//  TitleTableViewCell.swift
//  Netflix
//
//  Created by Abraam on 01.04.2022.
//

import UIKit
import SDWebImage
class TitleTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let titlePosterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titlePlayButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titlePlayButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageViewConstraint = [
            titlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            titlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            titlePosterImageView.widthAnchor.constraint(equalToConstant: 60)
        ]
        let titleLabelConstraint = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImageView.trailingAnchor,constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

        ]
        let titlePlayButtonConstraint = [
            titlePlayButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            titlePlayButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ]
        NSLayoutConstraint.activate(imageViewConstraint)
        NSLayoutConstraint.activate(titleLabelConstraint)
        NSLayoutConstraint.activate(titlePlayButtonConstraint)
    }
    public func configure(with model: TitleViewModelPresentation) {
        guard  let url  = URL(string: model.image) else { return }
       
       titlePosterImageView.sd_setImage(with: url,completed: nil)
        titlePosterImageView.image = UIImage(named: model.image)
        titleLabel.text = model.title
    }
    
    

}
