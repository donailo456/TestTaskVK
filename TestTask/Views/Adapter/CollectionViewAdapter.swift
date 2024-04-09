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
    
    private enum Constants {
        static let minimumSpaceCell: CGFloat = 13
        static let insertCellTop: CGFloat = 29
        static let insertCellLeft: CGFloat = 22
        static let insertCellBottom: CGFloat = 29
        static let insertCellRight: CGFloat = 22
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Square>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Square>
    
    // MARK: - Internal properties
    
    var onDidSelectRow: ((Square?) -> Void)?
    
    // MARK: - Private properties
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    private var cellDataSource: [Square]?
    private var boardSize: BoardSize = .small
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        setupCollectionView()
    }
    
    // MARK: - Internal Methods
    
    func reloadData(_ data: [Square]?, _ boardSize: BoardSize) {
        guard let data = data else { return }
        self.boardSize = boardSize
        cellDataSource = data
        configureCollectionViewDataSource()
        applySnapshot(square: cellDataSource ?? [])
        reloadCollection()
    }
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        self.collectionView?.backgroundColor = .systemGray
        self.collectionView?.delegate = self
        self.collectionView?.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    private func applySnapshot(square: [Square]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(square)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

//MARK: - UICollectionViewDelegate

extension CollectionViewAdapter {
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView ?? UICollectionView(), cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell
            let cellViewModel = self.cellDataSource?[indexPath.row]
            cell?.configure(with: cellViewModel)
            return cell
        })
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onDidSelectRow?(cellDataSource?[indexPath.row])
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch boardSize {
        case .small:
            return CGSize(width: 110, height: 110)
        case .big:
            return CGSize(width: 60, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.insertCellTop, left: Constants.insertCellLeft, bottom: Constants.insertCellBottom, right: Constants.insertCellRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.minimumSpaceCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

