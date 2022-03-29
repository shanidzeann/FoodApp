//
//  BannerPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import Foundation

protocol BannerPresenterProtocol {
    func numberOfItemsInSection(_ section: Int) -> Int
    func bannerImage(for indexPath: IndexPath) -> String
}
