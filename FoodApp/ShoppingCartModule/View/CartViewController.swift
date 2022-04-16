//
//  CartViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.04.2022.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    var presenter: CartPresenterProtocol!
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: Constants.TableView.CellIdentifiers.cartCell)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.tintColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Корзина"
        navigationController?.navigationBar.prefersLargeTitles = true
    
        addSubviews()
        setupConstraints()
        
        configureTableView()
        
        presenter.addToCart(CartItem(id: 1, title: "food", description: "d", price: 221, count: 1))

        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = view.frame.height/5
        tableView.allowsSelection = false
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(tableView.snp.bottom).offset(5)
            make.height.equalTo(50)
        }
    }

}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.CellIdentifiers.cartCell, for: indexPath) as! CartTableViewCell
        
        if let item = presenter.cartItem(for: indexPath) {
            let databaseManager = DatabaseManager()
            let cellPresenter = CartCellPresenter(view: cell, databaseManager: databaseManager, item: item)
            cell.inject(presenter: cellPresenter, delegate: self)
            
        }
        
        return cell
    }
    
}

extension CartViewController: UITableViewDelegate {
    
}

extension CartViewController: CartViewProtocol {
    
}

extension CartViewController: CartDelegate {
    func reloadData() {
        presenter.getCart()
        tableView.reloadData()
    }
}
