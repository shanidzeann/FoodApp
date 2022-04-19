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
        configureCheckoutButton()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
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
    }

    private func configureNavBar() {
        title = "Корзина"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configureCheckoutButton() {
        checkoutButton.setTitle(presenter.checkoutButton().title, for: .normal)
        checkoutButton.isEnabled = presenter.checkoutButton().isEnabled
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.rowHeight = view.frame.height/5
        tableView.allowsSelection = false
    }

}

extension CartViewController: CartDelegate {
    func reloadData() {
        tableView.reloadData()
        checkoutButton.setTitle(presenter.checkoutButton().title, for: .normal)
        checkoutButton.isEnabled = presenter.checkoutButton().isEnabled
    }
}
