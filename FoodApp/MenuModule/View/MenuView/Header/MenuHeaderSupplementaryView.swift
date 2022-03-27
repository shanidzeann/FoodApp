//
//  MenuHeaderSupplementaryView.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import UIKit

class MenuHeaderSupplementaryView: UICollectionReusableView {
    
    // MARK: - Properties
    
    private var presenter: MenuHeaderPresenterProtocol!
    
    // MARK: - UI
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .secondaryLabel
        label.text = "Section"
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
    
    // MARK: - Helper Methods
    
    func inject(presenter: MenuHeaderPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with urlString: String) {
        presenter.setTitle(for: urlString)
    }
    
    func createUI() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(15)
        }
    }
}

extension MenuHeaderSupplementaryView: MenuHeaderProtocol {
    func setTitle(_ title: String) {
        label.text = title
    }
}
