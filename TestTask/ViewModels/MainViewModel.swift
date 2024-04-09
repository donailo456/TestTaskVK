//
//  MainViewModel.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

final class MainViewModel: NSObject {
    
    // MARK: - Internal properties
    
    weak var coordinator: AppCoordinator?
    
    var onDataReload: (([Square]?) -> Void)?
    var onCheckWin: ((Bool) -> Void)?
    
    // MARK: - Private properties
    
    private var player1 = Player(name: "Player1", playerImage: "o", squares: [])
    private var player2 = Player(name: "Player2", playerImage: "x", squares: [])
    private var currentPlayer: Player = Player(name: "", playerImage: "", squares: [0])
    private var squares = [Square]()
    
    // MARK: - Internal Methods
    
    func createBoard() {
        let group = DispatchGroup()
        
        group.enter()
        for index in 1...9 {
            squares.append(Square(isChecked: false, squareIndex: index - 1, playerImage: nil))
        }
        group.leave()
        
        group.notify(queue: DispatchQueue.main) {
            self.onDataReload?(self.squares)
        }
    }
    
    func createPlayer() {
        player1.name = "X"
        player2.name = "O"
        currentPlayer = player1
    }
    
    func checkSquare(square: Square) {
        switch currentPlayer.name {
        case player1.name:
            if checkSquare(player: player1, squareIndex: square.squareIndex) == true {
                if !winOrDraw() {
                    currentPlayer = player2
                }
            }
        case player2.name:
            if checkSquare(player: player2, squareIndex: square.squareIndex) == true {
                if !winOrDraw() {
                    currentPlayer = player1
                }
            }
        default:
            return
        }
    }
    
    // MARK: - Private Methods
    
    private func checkSquare (player: Player, squareIndex: Int) -> Bool {
        guard !squares[squareIndex].isChecked else { return false }
        player.squares?.append(squareIndex)
        squares[squareIndex].isChecked = true
        squares[squareIndex].playerImage = UIImage(named: player.playerImage)
        return true
    }
    
    private func checkWin(player: Player, boardSize: Int) -> Bool {
        if let playerSquares = player.squares {
            var board = [[Bool]](repeating: [Bool](repeating: false, count: boardSize), count: boardSize)
            
            for square in playerSquares {
                let row = square / boardSize
                let col = square % boardSize
                board[row][col] = true
            }
            
            for i in 0..<boardSize {
                var horizontalWin = true
                var verticalWin = true
                for j in 0..<boardSize {
                    if !board[i][j] {
                        horizontalWin = false
                    }
                    if !board[j][i] {
                        verticalWin = false
                    }
                }
                if horizontalWin || verticalWin {
                    return true
                }
            }
            
            var diagonalWin1 = true
            var diagonalWin2 = true
            for i in 0..<boardSize {
                if !board[i][i] {
                    diagonalWin1 = false
                }
                if !board[i][boardSize - 1 - i] {
                    diagonalWin2 = false
                }
            }
            if diagonalWin1 || diagonalWin2 {
                return true
            }
        }
        return false
    }
    
    private func checkDraw(hasWon: Bool) -> Bool {
        var isDraw = false
        var index = 0
        if !hasWon {
            for square in squares {
                if square.isChecked {
                    index += 1
                }
            }
            if index == squares.count {
                isDraw = true
            }
        }
        
        return isDraw
    }
    
    private func resetBoard() {
        player1.squares?.removeAll()
        player2.squares?.removeAll()
        for square in squares {
            square.isChecked = false
            square.playerImage = nil
        }
        
        self.onDataReload?(self.squares)
    }
    
    private func winOrDraw() -> Bool {
        var gameEnded = false
        if checkWin(player: currentPlayer, boardSize: 3) {
            coordinator?.showWinnerAlert(restart: resetBoard)
            gameEnded = true
        } else if checkDraw(hasWon: checkWin(player: currentPlayer, boardSize: 3)) {
            coordinator?.showWinnerAlert(restart: resetBoard)
            gameEnded = true
        }
        return gameEnded
    }
}
