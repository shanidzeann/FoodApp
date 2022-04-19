//
//  CardPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 19.04.2022.
//

import Foundation

protocol CardPresenterProtocol {
    func numberOfRowsInSection() -> Int
    func cellText(for indexPath: IndexPath) -> (attributedString: NSMutableAttributedString, range: NSRange)
}
