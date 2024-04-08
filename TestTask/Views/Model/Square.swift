//
//  Square.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

class Square: Hashable {
    var isChecked: Bool
    var squareIndex: Int
    var playerImage: UIImage?
    
    init(isChecked: Bool, squareIndex: Int, playerImage: UIImage?) {
        self.isChecked = isChecked
        self.squareIndex = squareIndex
        self.playerImage = playerImage
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(isChecked)
            hasher.combine(squareIndex)
            hasher.combine(playerImage)
    }
    
    static func == (lhs: Square, rhs: Square) -> Bool {
        return lhs.isChecked == rhs.isChecked &&
                       lhs.squareIndex == rhs.squareIndex &&
                       lhs.playerImage == rhs.playerImage
    }
}
