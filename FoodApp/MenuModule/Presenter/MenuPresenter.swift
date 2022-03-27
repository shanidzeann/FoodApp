//
//  MenuPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation


class MenuPresenter: MenuPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: MenuViewProtocol?
    let networkManager: NetworkManagerProtocol!
    var menu: [Result<(url: String, menu: Menu), Error>]?
    
    // MARK: - Init
    
    required init(view: MenuViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    //    getMenu()
    }
    
    // MARK: - Helper Methods
    
    func getMenu() {
        networkManager.downloadMenu { results in
            self.menu = results
        }
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return 10
//            switch menu[section] {
//            case .success(let result):
//                return result.menu.menuItems.count
//            case .failure(let error):
//                print(error)
//                return 0
//            }
    }
    
    func numberOfSections() -> Int {
        return 3
        //return menu.count
    }
    
    func menuItem(for indexPath: IndexPath) -> MenuItem? {
        guard let menu = menu else { return nil }

        switch menu[indexPath.section] {
        case .success(let result):
            return result.menu.menuItems[indexPath.row]
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    func url(for indexPath: IndexPath) -> String? {
        guard let menu = menu else { return nil }
        switch menu[indexPath.section] {
        case .success(let result):
            return result.url
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
}
