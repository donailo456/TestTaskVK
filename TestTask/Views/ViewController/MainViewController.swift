//
//  ViewController.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var viewModel: MainViewModel?
    
    // MARK: - Private properties
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var button3x3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("3x3", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        button.addTarget(self, action: #selector(action3x3), for: .touchUpInside)
        return button
    }()
    
    private lazy var button5x5: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("5x5", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        button.addTarget(self, action: #selector(action5x5), for: .touchUpInside)
        return button
    }()
    
    private lazy var adapter = CollectionViewAdapter(collectionView: mainCollectionView)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupViews()
        viewModel?.createPlayer()
        bindViewModel()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(mainCollectionView)
        view.addSubview(button3x3)
        view.addSubview(button5x5)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 125),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: button3x3.topAnchor),
            
            button3x3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            button3x3.topAnchor.constraint(equalTo: mainCollectionView.bottomAnchor),
            button3x3.centerYAnchor.constraint(equalTo: button5x5.centerYAnchor),
            
            button5x5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button5x5.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            
        ])
    }
    
    private func bindViewModel() {
        viewModel?.createBoard(boardSize: BoardSize.small)
        
        viewModel?.onDataReload = { data, size in
            self.adapter.reloadData(data, size)
        }
        
        adapter.onDidSelectRow = { cell in
            guard let cell = cell else { return }
            self.viewModel?.checkSquare(square: cell)
        }
    }
    
    @objc
    private func action3x3() {
        viewModel?.createBoard(boardSize: BoardSize.small)
    }
    
    @objc
    private func action5x5() {
        viewModel?.createBoard(boardSize: BoardSize.big)
    }
}

