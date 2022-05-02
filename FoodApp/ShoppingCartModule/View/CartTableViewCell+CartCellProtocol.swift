//
//  CartTableViewCell+CartCellProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 02.05.2022.
//

import UIKit

extension CartTableViewCell: CartCellProtocol {
    func reloadData() {
        cartDelegate.reloadData()
    }
    
    func setData(title: String, description: String, price: String, imageUrl: String, count: String) {
        titleLabel.text = title
        desctiptionLabel.text = description
        priceLabel.text = price + " ₽"
        countLabel.text = count
        cartImageView.kf.setImage(with: URL(string: imageUrl)) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.cartImageView.image = UIImage(systemName: "fork.knife.circle")
                self.cartImageView.tintColor = .black
            }
        }
    }
}
