//
//  OrderHistoryViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var presenter: OrderHistoryPresenterProtocol!
    var ordersCollectionView: UICollectionView?
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои заказы"
        view.backgroundColor = .secondarySystemBackground
        createCollectionView()
        addSubviews()
        setupConstraints()
        presenter.getUserOrders()
    }
    
    // MARK: - Injection
    
    func inject(_ presenter: OrderHistoryPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - UI
    
    func addSubviews() {
        view.addSubview(ordersCollectionView ?? UICollectionView())
    }
    
    func setupConstraints() {
        ordersCollectionView?.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        })
    }
    
    private func createCollectionView() {
        ordersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        ordersCollectionView?.tag = 0
        ordersCollectionView?.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionView.CellIdentifiers.orderCell)
        ordersCollectionView?.dataSource = self
        ordersCollectionView?.delegate = self
        ordersCollectionView?.allowsSelection = false
        ordersCollectionView?.backgroundColor = .clear
        ordersCollectionView?.showsHorizontalScrollIndicator = false
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
}
