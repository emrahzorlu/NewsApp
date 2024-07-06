//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 4.07.2024.
//

import UIKit
import SnapKit

protocol MainDisplayLayer: BaseControllerProtocol {
    func setupUI()
    func reloadCollectionView()
    func setDataSource(dataSource: DataSource)
    func pushViewController(viewController: NewsDetailViewController)
}

final class NewsViewController: BaseViewController, MainDisplayLayer {
    
    private var viewModel: MainBusinessLayer
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(viewModel: MainBusinessLayer) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.viewDidLoad()
    }
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 2 - 16, height: 275)
        collectionView.collectionViewLayout = layout
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-5)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-5)
        }
    }
        
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func setDataSource(dataSource: DataSource) {
        dataSource.sections.forEach({ $0.registerCells(for: collectionView) })
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    func pushViewController(viewController: NewsDetailViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
