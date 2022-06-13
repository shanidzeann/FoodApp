//
//  ProfileViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//


import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var presenter: ProfilePresenterProtocol!
    
    // MARK: - UI
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableView.CellIdentifiers.cell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        return tableView
    }()
    
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Injection
    
    func inject(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(userImageView)
        view.addSubview(nameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(emailLabel)
        view.addSubview(menuTableView)
    }
    
    private func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(80.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(nameLabel)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.left.right.equalTo(phoneLabel)
        }
        
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}
