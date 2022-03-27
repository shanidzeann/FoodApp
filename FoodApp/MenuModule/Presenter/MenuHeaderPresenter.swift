//
//  MenuHeaderPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

class MenuHeaderPresenter: MenuHeaderPresenterProtocol {
    weak var view: MenuHeaderProtocol?
    
    required init(view: MenuHeaderProtocol) {
        self.view = view
    }
    
    func setTitle(for urlString: String) {
        
        var headerTitle = ""
        
        if urlString.contains("pizza") {
            headerTitle = "Pizza"
        } else if urlString.contains("burger") {
            headerTitle = "Burgers"
        }
        
        view?.setTitle(headerTitle)
    }
}
