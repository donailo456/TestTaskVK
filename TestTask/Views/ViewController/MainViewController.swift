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
    
    var currentPlayer: Player = Player(name: "", playerImage: "", squares: [0])
    var dataSource = [Square]()
    var player1 = Player(name: "", playerImage: "", squares: nil)
    var player2 = Player(name: "", playerImage: "", squares: nil)
    var player1Name = ""
    var player2Name = ""
    
    // MARK: - Private properties
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
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
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 125),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
        ])
    }
    
    private func bindViewModel() {
        viewModel?.createBoard()
        
        viewModel?.onDataReload = { data in
            self.adapter.reload(data)
        }
        
        adapter.onDidSelectRow = { cell in
            guard let cell = cell else { return }
            self.viewModel?.checkSquare(square: cell)
        }
    }
}

