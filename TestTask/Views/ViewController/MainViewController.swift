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
        createPlayer()
        bindViewModel()
    }
    
    // MARK: - Private Methods
    
    private func createPlayer() {
        viewModel?.createPlayer(namep1: player1Name, namep2: player2Name)
        if let player1 = viewModel?.getPlayer1() {
            self.player1 = player1
        }
        if let player2 = viewModel?.getPlayer2() {
            self.player2 = player2
        }
        currentPlayer = player1
    }
    
    private func checkSquare (square: Square) {
        switch currentPlayer.name {
        case player1.name:
            if viewModel?.checkSquare(player: player1, squareIndex: square.squareIndex) == true {
                if !winOrDraw() {
                    currentPlayer = player2
                }
            }
        case player2.name:
            if viewModel?.checkSquare(player: player2, squareIndex: square.squareIndex) == true {
                if !winOrDraw() {
                    currentPlayer = player1
                }
            }
        default:
            return
        }
    }
    
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
    
    private func showWinnerAlert() {
        let alertController = UIAlertController(title: "Игра окончена", message: nil, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Начать заново", style: .default) { [weak self] _ in
            self?.viewModel?.resetBoard() // Перезапуск игры
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func bindViewModel() {
        viewModel?.createBoard()
        
        viewModel?.onDataReload = { data in
            self.adapter.reload(data)
        }
        
        adapter.onDidSelectRow = { cell in
            guard let cell = cell else { return }
            self.checkSquare(square: cell)
        }
    }
    
    private func winOrDraw() -> Bool {
        var gameEnded = false
        guard let chekDraw = viewModel?.checkDraw(hasWon: viewModel?.checkWin(player: currentPlayer) ?? false) else { return gameEnded }
        guard let chekWin = viewModel?.checkWin(player: currentPlayer) else { return gameEnded }
        if chekWin {
            showWinnerAlert()
            gameEnded = true
        } else if chekDraw {
            showWinnerAlert()
            gameEnded = true
        }
        return gameEnded
    }
}

