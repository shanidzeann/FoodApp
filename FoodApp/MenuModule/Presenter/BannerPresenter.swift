//
//  BannerPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import Foundation

class BannerPresenter: BannerPresenterProtocol {
    
    // MARK: - Properties

    let images = ["image1.png", "image2.png"]
    
    // MARK: - Helper Methods
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return images.count
    }
    
    func bannerImage(for indexPath: IndexPath) -> String {
        return images[indexPath.item]
    }
    
    
}
