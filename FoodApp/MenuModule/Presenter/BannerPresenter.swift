//
//  BannerPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import Foundation

final class BannerPresenter: BannerPresenterProtocol {

    let images = ["image1.png", "image2.png"]
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return images.count
    }
    
    func bannerImage(for indexPath: IndexPath) -> String {
        return images[indexPath.item]
    }
    
}
