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
            setNavControllerTitle("")
            showCartButton(true)
            setNavBarColor(.systemBackground)
        case .profile:
            setNavControllerTitle("")
            showCartButton(false)
            showProfileOrLogin()
        case .delivery:
            showCartButton(false)
            setNavControllerTitle("Доставка")
            show(createDeliveryVC(), style: .replace)
        }
    }
    
    private func showCartButton(_ isShowed: Bool) {
        navController?.navigationBar.topItem?.rightBarButtonItem = isShowed ? homeVC.cartButton : nil
    }
    
    private func setNavControllerTitle(_ title: String) {
        navController?.navigationBar.topItem?.title = title
    }
    
    private func setNavBarColor(_ color: UIColor) {
        navController?.navigationBar.barTintColor = color
    }
    
}
