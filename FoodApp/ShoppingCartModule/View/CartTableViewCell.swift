//
//  CartTableViewCell.swift
//  FoodApp
//
//  Created by Anna Shanidze on 15.04.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    private var presenter: CartCellPresenterProtocol!
    
    // MARK: - UI
    
    private let cartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.text = "Food"
        return label
    }()
    
    private let desctiptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "nyam"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = "884"
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.text = "10"
        label.textAlignment = .center
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    func inject(presenter: CartCellPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with item: MenuItem) {
      //  presenter.configure(with: item)
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func createUI() {
        contentView.addSubview(cartImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(desctiptionLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(deleteButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(countLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        cartImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
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
            make.height.equalTo(20)
            make.right.lessThanOrEqualTo(deleteButton.snp.left)
        }
        
        addButton.snp.makeConstraints { make in
            make.right.equalTo(titleLabel)
            make.height.width.equalTo(20)
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