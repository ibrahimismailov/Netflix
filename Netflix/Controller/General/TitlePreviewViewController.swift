//
//  TitlePreviewViewController.swift
//  Netflix
//
//  Created by Abraam on 04.05.2022.
//

import UIKit
import WebKit
class TitlePreviewViewController: UIViewController {
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 22, weight: .bold)
            label.text = "Harry Potter"
            label.textColor = .secondaryLabel
            label.numberOfLines = 0
            return label
        }()
        private let overViewLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 13, weight: .heavy)
            label.text = "Best Movies ever i watched"
            label.textColor = .secondaryLabel
            label.numberOfLines = 0
            return label
        }()
        private let downloadButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .red
            button.setTitle("Download", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.layer.masksToBounds = true
            return button
        }()
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(webView)
            view.addSubview(titleLabel)
            view.addSubview(overViewLabel)
            view.addSubview(downloadButton)
            configureConstraints()
        }
    private func configureConstraints() {
       
        let webkitConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        let titleLableConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        ]
        let overViewLabelConstraints = [
            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor,constant: 30),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
            NSLayoutConstraint.activate(webkitConstraints)
            NSLayoutConstraint.activate(titleLableConstraints)
            NSLayoutConstraint.activate(overViewLabelConstraints)
            NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overViewLabel.text = model.titleOverView
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
