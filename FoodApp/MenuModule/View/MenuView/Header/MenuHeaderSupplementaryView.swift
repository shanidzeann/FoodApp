//
//  MenuHeaderSupplementaryView.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import UIKit

final class MenuHeaderSupplementaryView: UICollectionReusableView {
    
    // MARK: - UI
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .secondaryLabel
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    func configure(with title: String) {
        label.text = title
    }
    
    func createUI() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(15)
        }
    }
}
