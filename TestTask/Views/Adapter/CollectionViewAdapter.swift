//
//  CollectionViewAdapter.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

final class CollectionViewAdapter: NSObject {
    
    // MARK: - Constants
    
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Square>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Square>
    
    // MARK: - Private properties
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    private var cellDataSource: [Square]?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
    }
    
}
