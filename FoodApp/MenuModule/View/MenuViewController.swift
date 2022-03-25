//
//  ViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    var presenter: MenuPresenterProtocol!
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionView.CellIdentifiers.menuCell)
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: Constants.CollectionView.Headers.elementKind, withReuseIdentifier: Constants.CollectionView.Headers.menuHeader)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionKind {
            case .banner:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 20, leading: 0, bottom: 10, trailing: 0)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
                
            case .menu:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.4))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: 0, bottom: 1, trailing: 0)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.15))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: Constants.CollectionView.Headers.elementKind, alignment: .top)
                header.pinToVisibleBounds = true
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [header]
                
                return section
            }
        }
        return layout
    }
    
    
}

extension MenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.CellIdentifiers.menuCell, for: indexPath)
        
//        cellPresenter = MenuCellPresenter(view: cell)
//        cell.inject(presenter: cellPresenter)
//
//        if let item = presenter.item(for: indexPath) {
//            cell.configure(item: item)
//        }
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.CollectionView.Headers.menuHeader, for: indexPath) as? MenuHeaderSupplementaryView else { return UICollectionReusableView() }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.CollectionView.Headers.menuHeader, for: indexPath)
//        headerPresenter = MenuHeaderPresenter(view: headerView)
//        headerView.inject(presenter: headerPresenter)
        
        headerView.backgroundColor = .blue
        
        return headerView
    }
    
}

extension MenuViewController: UICollectionViewDelegate {
    
}

extension MenuViewController: MenuViewProtocol {
    
}

