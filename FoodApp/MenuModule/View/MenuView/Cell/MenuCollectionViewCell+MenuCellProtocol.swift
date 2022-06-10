//
//  MenuCollectionViewCell+MenuCellProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 10.06.2022.
//

import UIKit

extension MenuCollectionViewCell: MenuCellProtocol {
    #warning("item?")
    func setData(title: String, description: String, price: String, imageURL: URL?, subtitle: String?) {
        titleLabel.text = title
        desctiptionLabel.text = description
        priceButton.setTitle(price, for: .normal)
        priceButton.configuration?.subtitle = subtitle
        priceButton.configuration?.attributedSubtitle?.font = .systemFont(ofSize: 8)
        
        menuImageView.kf.setImage(with: imageURL) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.menuImageView.image = UIImage(systemName: "fork.knife.circle")
                self.menuImageView.tintColor = .black
            }
        }
    }
}
