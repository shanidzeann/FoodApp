//
//  MenuPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

final class MenuPresenter: MenuPresenterProtocol {
    
    // MARK: - Properties
    
    let networkManager: NetworkManagerProtocol
    var menu: [Result<(url: String, menu: Menu), Error>]?
    var sections = [(title: String, itemsCount: Int)]()
    
    // MARK: - Init
    
    required init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        getMenu()
        getSectionTitles()
    }
    
    // MARK: - Methods
    
    func getMenu() {
        networkManager.downloadMenu { results in
            self.menu = results
        }
    }
    
    func numberOfSections() -> Int {
        return menu?.count ?? 0
    }
    
    func menuItem(for indexPath: IndexPath) -> MenuItem? {
        guard let menu = menu else { return nil }
        
        switch menu[indexPath.section] {
        case .success(let result):
            return result.menu.menuItems[indexPath.item]
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        guard let menu = menu else {
            return 0
        }
        
        switch menu[section] {
        case .success(let result):
            return result.menu.menuItems.count
        case .failure(let error):
            print(error)
            return 0
        }
    }
    
    private func getSectionTitles() {
        let categories = getCategoriesData()
        for category in categories {
            if let titleRange = category.url.range(of: #"=[a-z]*&"#,
                                             options: .regularExpression) {
                let title = category.url[titleRange].dropFirst().dropLast().description.capitalized
                sections.append((title: title, itemsCount: category.itemsCount))
            }
        }
    }
    
    private func getCategoriesData() -> [(url: String, itemsCount: Int)] {
        var categoriesData = [(url: String, itemsCount: Int)]()
        guard let menu = menu else { return [] }
        for category in menu {
            switch category {
            case .success(let result):
                categoriesData.append((url: result.url, itemsCount: result.menu.menuItems.count))
            case .failure(let error):
                print(error)
                categoriesData.append((url: "Error", itemsCount: 0))
            }
        }
        return categoriesData
    }
    
    func sectionTitle(for section: Int) -> String {
        return sections[section].title
    }
    
}
