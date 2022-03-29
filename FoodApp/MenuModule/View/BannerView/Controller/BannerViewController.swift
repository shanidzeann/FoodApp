//
//  CardMenuViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 26.03.2022.
//

import UIKit

class BannerViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: BannerPresenterProtocol!
    private var collectionView: UICollectionView!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
        setupConstraints()
    }
    
    // MARK: - UI
    
    private func createCollectionView() {
        view.backgroundColor = .secondarySystemBackground
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionView.CellIdentifiers.bannerCell)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}


// MARK: - BannerViewProtocol

extension BannerViewController: BannerViewProtocol {
    
}
