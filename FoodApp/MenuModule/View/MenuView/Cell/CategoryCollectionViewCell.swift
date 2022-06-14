//
//  CategoryCollectionViewCell.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = contentView.frame.height/2
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    private func createUI() {
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
}

