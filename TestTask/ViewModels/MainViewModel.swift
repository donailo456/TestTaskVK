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
    private var squares = [Square]()
    private let winningCombinations3x3 = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    // MARK: - Internal Methods
    
    func createPlayer(namep1: String, namep2: String) {
        if namep1 != "" {
            player1.name = namep1
        } else if namep1 == "" {
            player1.name = "Player 1"
        }
        if namep2 != "" {
            player2.name = namep2
        } else if namep2 == ""{
            player2.name = "Player 2"
        }
    }
    
    func getPlayer1 () -> Player {
        return player1
    }
    
    func getPlayer2 () -> Player {
        return player2
    }
    
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
    
    func checkSquare (player: Player, squareIndex: Int) -> Bool {
        if squares[squareIndex].isChecked {
            return false
        } else {
            player.squares?.append(squareIndex)
            squares[squareIndex].isChecked = true
            squares[squareIndex].playerImage = UIImage(named: player.playerImage)
            return true
        }
    }
    
    func checkWin(player: Player) -> Bool {
        var hasWon = false
        onCheckWin?(false)
        if let playerSquares = player.squares {
            for numbers in winningCombinations3x3 {
                if playerSquares.contains(numbers[0]) && playerSquares.contains(numbers[1]) &&
                    playerSquares.contains(numbers[2]) {
                    for square in squares {
                        square.isChecked = true
                    }
                    hasWon = true
                    onCheckWin?(true)
                }
            }
        }
        return hasWon
    }
    
    func checkDraw(hasWon: Bool) -> Bool {
        var isDraw = false
        var index = 0
        if hasWon == false {
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
    
    func resetBoard() {
        player1.squares?.removeAll()
        player2.squares?.removeAll()
        for square in squares {
            square.isChecked = false
            square.playerImage = nil
        }
        
        self.onDataReload?(self.squares)
    }
    
}
