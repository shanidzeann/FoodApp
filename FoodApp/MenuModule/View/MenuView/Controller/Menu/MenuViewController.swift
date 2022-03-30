//
//  MenuViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: MenuPresenterProtocol!
    var menuCollectionView: UICollectionView?
    var categoriesCollectionView: UICollectionView?
    let cardVC = CardViewController()
    
    private let moreButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "text.justify")
        button.configuration = config
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return button
    }()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCardVC()
        configureView()
        addSubviews()
        createCategoriesCollectionView()
        createMenuCollectionView()
        moreButton.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    // MARK: - UI
    
    @objc private func didTapMore() {
        present(cardVC, animated: true, completion: nil)
    }
    
    private func configureCardVC() {
        cardVC.modalPresentationStyle = .custom
        cardVC.transitioningDelegate = self
        cardVC.sections = presenter.sections
        cardVC.menu = self
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }
    
    private func addSubviews() {
        view.addSubview(moreButton)
    }
    
    private func createCategoriesCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoriesCollectionView?.tag = 0
        categoriesCollectionView?.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionView.CellIdentifiers.categoryCell)
        categoriesCollectionView?.dataSource = self
        categoriesCollectionView?.delegate = self
        categoriesCollectionView?.backgroundColor = .clear
        categoriesCollectionView?.showsHorizontalScrollIndicator = false
        view.addSubview(categoriesCollectionView ?? UICollectionView())
    }
    
    private func createMenuCollectionView() {
        menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        menuCollectionView?.tag = 1
        menuCollectionView?.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionView.CellIdentifiers.menuCell)
        menuCollectionView?.register(MenuHeaderSupplementaryView.self, forSupplementaryViewOfKind: Constants.CollectionView.Headers.elementKind, withReuseIdentifier: Constants.CollectionView.Headers.menuHeader)
        menuCollectionView?.dataSource = self
        menuCollectionView?.delegate = self
        menuCollectionView?.backgroundColor = .clear
        menuCollectionView?.showsVerticalScrollIndicator = false
        view.addSubview(menuCollectionView ?? UICollectionView())
        
        menuCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.4))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: Constants.CollectionView.Headers.elementKind, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        return layout
    }
    
    private func layout() {
        categoriesCollectionView?.frame = CGRect(x: 50, y: 0, width: view.frame.width - 50, height: 50)
        NSLayoutConstraint.activate([
            menuCollectionView!.topAnchor.constraint(equalTo: categoriesCollectionView!.bottomAnchor),
            menuCollectionView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuCollectionView!.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            menuCollectionView!.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}


// MARK: - MenuViewProtocol

extension MenuViewController: MenuViewProtocol {
    
}
