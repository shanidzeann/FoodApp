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
    
    private let emptyCartImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "cart_empty.png")
        return imageView
    }()
    
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
        button.layer.cornerRadius = 10
        button.setTitleColor(.lightGray, for: .disabled)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavBar()
        addSubviews()
        setupConstraints()
        configureTableView()
        presenter.checkCart()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
        view.addSubview(emptyCartImageView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(tableView.snp.bottom).offset(5)
            make.height.equalTo(50)
        }
        
        emptyCartImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.center.equalToSuperview()
            
        }
    }

    private func configureNavBar() {
        title = "Корзина"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.rowHeight = view.frame.height/5
        tableView.allowsSelection = false
    }

}

extension CartViewController: CartViewProtocol {
    func configureCheckoutButton(title: String, isEnabled: Bool) {
        checkoutButton.setTitle(title, for: .normal)
        checkoutButton.isEnabled = isEnabled
    }
    
    func showEmptyCart() {
        tableView.alpha = 0
        emptyCartImageView.alpha = 1
    }
    
    func showCart() {
        tableView.alpha = 1
        emptyCartImageView.alpha = 0
    }
}

extension CartViewController: CartDelegate {
    func reloadData() {
        tableView.reloadData()
        presenter.checkCart()
    }
}
