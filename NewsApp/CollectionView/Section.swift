//
//  Section.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 5.07.2024.
//

import Foundation
import UIKit

struct NewsListSection {
    var cellModels: [News]
    let didSelectHandler: ((News) -> ())?
    
}

extension NewsListSection: CollectionSectionProtocol {
    
    func numberOfCell() -> Int {
        return cellModels.count
    }
    
    func itemDidSelect(in collectionView: UICollectionView, at index: Int) {
        didSelectHandler?(cellModels[index])
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCell")
    }
    
    func dequeReusableCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for:indexPath) as! NewsCollectionViewCell
        let model = cellModels[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    
    func sizeForItemAt(for collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, at indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        let height: CGFloat = 275
        return CGSize(width: width, height: height)
    }
}
