//
//  OrderCollectionViewCell.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class OrderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private(set) var presenter: OrderCellPresenterProtocol!
    
    // MARK: - UI
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 10.0
        ).cgPath
    }
    
    // MARK: - Injection
    
    func inject(_ presenter: OrderCellPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with order: Order) {
        presenter.configure(with: order)
    }
    
    // MARK: - UI
    
    private func configureView() {
        backgroundColor = .systemBackground
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
        
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func addSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        let inset = 10.0
        dateLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(inset)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(inset)
            make.left.right.equalToSuperview().inset(inset)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.left.greaterThanOrEqualTo(dateLabel.snp.right).inset(inset)
            make.right.equalToSuperview().inset(inset)
        }
    }

}
