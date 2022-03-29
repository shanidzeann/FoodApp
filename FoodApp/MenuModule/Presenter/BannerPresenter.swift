//
//  BannerPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import Foundation

class BannerPresenter: BannerPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: BannerViewProtocol?
    let images = ["image1.png", "image2.png"]
    
    // MARK: - Init
    
    required init(view: BannerViewProtocol) {
        self.view = view
    }
    
    // MARK: - Helper Methods
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return images.count
    }
    
    func bannerImage(for indexPath: IndexPath) -> String {
        return images[indexPath.item]
    }
    
    
}
