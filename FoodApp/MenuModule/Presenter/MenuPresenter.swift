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
    var menu: [Result<(url: String, menu: Menu), Error>]!
    
    // MARK: - Init
    
    required init(view: MenuViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        getMenu()
    }
    
    // MARK: - Helper Methods
    
    func getMenu() {
        networkManager.downloadMenu { results in
            self.menu = results
        }
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
     //   let sectionKind = Section(rawValue: section)
        if section == 0  {
            return 2
        } else {
            switch menu[section - 1] {
            case .success(let result):
                return result.menu.menuItems.count
            case .failure(let error):
                print(error)
                return 0
            }
        }
    }
    
    func numberOfSections() -> Int {
        print(menu.count)
        return menu.count + 1
    }
    
}
