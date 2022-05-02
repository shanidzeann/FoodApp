//
//  CartTableViewCell.swift
//  FoodApp
//
//  Created by Anna Shanidze on 15.04.2022.
//

import UIKit
import Kingfisher

class CartTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    private var presenter: CartCellPresenterProtocol!
    private(set) var cartDelegate: CartDelegate!
    
    // MARK: - UI
    
    let cartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        return label
    }()
    
    let desctiptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        configureView()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    func inject(presenter: CartCellPresenterProtocol, delegate: CartDelegate) {
        self.presenter = presenter
        self.cartDelegate = delegate
    }
    
    @objc private func didTapAdd() {
        presenter.addToCart()
    }
    
    @objc private func didTapDelete() {
        presenter.deleteFromCart()
    }
    
    private func addSubviews() {
        contentView.addSubview(cartImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(desctiptionLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(deleteButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func addTargets() {
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        cartImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(cartImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(cartImageView.snp.right).offset(10)
            make.top.right.equalToSuperview().inset(10)
        }
        
        desctiptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(titleLabel)
            make.bottom.lessThanOrEqualTo(priceLabel.snp.top).offset(1)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(desctiptionLabel)
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(25)
            make.right.lessThanOrEqualTo(deleteButton.snp.left)
        }
        
        addButton.snp.makeConstraints { make in
            make.right.equalTo(titleLabel)
            make.height.width.equalTo(25)
            make.bottom.equalTo(priceLabel)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.bottom.width.height.equalTo(addButton)
            make.right.equalTo(addButton.snp.left).offset(1)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.bottom.width.height.equalTo(addButton)
            make.right.equalTo(countLabel.snp.left).offset(1)
        }
        
    }
    
    override func prepareForReuse() {
        cartImageView.kf.cancelDownloadTask()
        cartImageView.kf.setImage(with: URL(string: ""))
        cartImageView.image = nil
    }
}
