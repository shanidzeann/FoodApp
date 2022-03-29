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
    var sections = [String]()
    
    // MARK: - Init
    
    required init(view: MenuViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        getMenu()
        getSectionTitles()
    }
    
    // MARK: - Helper Methods
    
    func getMenu() {
        networkManager.downloadMenu { results in
            self.menu = results
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
    
    private func getSectionTitles() {
        let urls = urls()
        for url in urls {
            if let titleRange = url.range(of: #"=[a-z]*&"#,
                                             options: .regularExpression) {
                let title = url[titleRange].dropFirst().dropLast().description.capitalized
                sections.append(title)
            }
        }
    }
    
    private func urls() -> [String] {
        var urlArray = [String]()
        guard let menu = menu else { return [] }
        for category in menu {
            switch category {
            case .success(let result):
                urlArray.append(result.url)
            case .failure(let error):
                print(error)
                urlArray.append("Error")
            }
        }
        return urlArray
    }
    
    func sectionTitle(for section: Int) -> String {
        return sections[section]
    }
    
}
