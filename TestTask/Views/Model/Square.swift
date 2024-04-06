//
//  Square.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

struct Square: Hashable {
    var isChecked: Bool
    var squareIndex: Int
    var playerImage: UIImage?
    
    init(isChecked: Bool, squareIndex: Int, playerImage: UIImage?) {
        self.isChecked = isChecked
        self.squareIndex = squareIndex
        self.playerImage = playerImage
    }
}
