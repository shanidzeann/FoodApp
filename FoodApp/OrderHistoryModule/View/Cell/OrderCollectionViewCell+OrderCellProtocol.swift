//
//  OrderCollectionViewCell+OrderCellProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import UIKit

extension OrderCollectionViewCell: OrderCellProtocol {
    func setData(order: Order) {
        dateLabel.text = presenter.stringFrom(order.date!)
        addressLabel.text = order.address
        priceLabel.text = "\(order.totalPrice ?? 0) ₽"
    }
}
