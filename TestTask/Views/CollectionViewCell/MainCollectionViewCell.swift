//
//  MainCollectionViewCell.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        
    }
    
    // MARK: - Internal properties
    
    static let identifier = "MainCollectionViewCell"
    
    // MARK: - Private properties
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal properties
    
    func configure(with boardIndex: Square?) {
        self.imageView.image = boardIndex?.playerImage
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        contentView.backgroundColor = .white
        self.contentView.addSubview(imageView)
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

}
