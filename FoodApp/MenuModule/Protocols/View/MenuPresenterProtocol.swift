//
//  MenuPresenterProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

protocol MenuPresenterProtocol {
    func numberOfItemsInSection(_ section: Int) -> Int
    func numberOfSections() -> Int
    func menuItem(for indexPath: IndexPath) -> MenuItem?
    var sections: [String] { get set }
    func sectionTitle(for section: Int) -> String
}
