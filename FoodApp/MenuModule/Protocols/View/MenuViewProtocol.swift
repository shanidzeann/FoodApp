//
//  MenuViewProtocol.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

protocol MenuViewProtocol: AnyObject {
    var presenter: MenuPresenterProtocol! { get set }
}
