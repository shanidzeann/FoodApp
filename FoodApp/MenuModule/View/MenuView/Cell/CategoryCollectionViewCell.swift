//
//  CategoryCollectionViewCell.swift
//  FoodApp
//
//  Created by Anna Shanidze on 28.03.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    //private var presenter: MenuCellPresenterProtocol!
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.text = "Fuukdhfkdhfksdd"
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        
        backgroundColor = .systemBackground
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = contentView.frame.height/2
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
//    
//    func inject(presenter: MenuCellPresenterProtocol) {
//        self.presenter = presenter
//    }
//    
//    func configure(with item: MenuItem) {
//        presenter.configure(with: item)
//    }
    
    private func createUI() {
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
}

