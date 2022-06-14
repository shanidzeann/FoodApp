//
//  CartViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.04.2022.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CartPresenterProtocol!
    
    // MARK: - UI
    
    let emptyCartImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "empty_cart.png")
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: Constants.TableView.CellIdentifiers.cartCell)
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let checkoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitleColor(.lightGray, for: .disabled)
        return button
    }()
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavBar()
        addSubviews()
        setupConstraints()
        configureTableView()
        presenter.checkCart()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - UI
    
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
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.rowHeight = view.frame.height/6
        tableView.allowsSelection = false
    }
    
    // MARK: - Actions
    
    private func addTargets() {
        checkoutButton.addTarget(self, action: #selector(checkout), for: .touchUpInside)
    }
    
    // MARK: - Order Creation
    
    @objc private func checkout() {
        presenter.checkout { message in
            if message != nil {
                show(message!)
            } else {
                navigationController?.pushViewController(checkoutVC(), animated: true)
            }
        }
    }
    
    private func checkoutVC() -> CheckoutViewController {
        let checkoutVC = CheckoutViewController()
        let presenter = CheckoutPresenter(view: checkoutVC,
                                          firestoreManager: FirestoreManager(),
                                          localDatabaseManager: LocalDatabaseManager.shared)
        checkoutVC.inject(presenter)
        return checkoutVC
    }
    
    private func show(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        
        present(alert, animated: true)
    }

}
