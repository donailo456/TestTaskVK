//
//  MainCollectionViewCell.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    
    static let identifier = "MainCollectionViewCell"
    
    // MARK: - Private properties
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
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
        imageView.image = boardIndex?.playerImage
    }
    
    
    // MARK: - Private Methods
    
    private func setupViews() {
        contentView.backgroundColor = .white
        self.contentView.addSubview(imageView)
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 76),
        ])
    }
}
