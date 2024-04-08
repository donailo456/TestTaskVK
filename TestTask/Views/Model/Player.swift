//
//  Player.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

class Player {
    var name: String
    var playerImage: String
    var squares: [Int]?
    
    init(name: String, playerImage: String, squares: Array<Int>?) {
        self.name = name
        self.playerImage = playerImage
        self.squares = squares
    }
}
