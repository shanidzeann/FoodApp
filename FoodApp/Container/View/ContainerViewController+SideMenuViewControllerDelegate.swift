//
//  ContainerViewController+SideMenuViewControllerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import UIKit

extension ContainerViewController: SideMenuViewControllerDelegate {
    func didSelect(menuItem: MenuOptions) {
        toggleMenu()
        removeUnnecessaryChildIfExists()
        showSelected(menuItem)
    }
    
    private func showSelected(_ menuItem: MenuOptions) {
        switch menuItem {
        case .home:
            changeNavControllerTitle("")
            hideCartButton(false)
            resetToHome()
        case .profile:
            changeNavControllerTitle("")
            hideCartButton(true)
            showProfileOrLogin()
        case .delivery:
            hideCartButton(true)
            changeNavControllerTitle("Доставка")
            show(deliveryVC(), style: .replace)
        }
    }
    
}
