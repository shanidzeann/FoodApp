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
        checkChildren()
        switch menuItem {
        case .home:
            resetToHome()
        case .profile:
            break
        case .delivery:
            addDeliveryVC()
        }
    }
    
    func resetToHome() {
        navController?.navigationBar.barTintColor = .systemBackground
        checkChildren()
    }
    
    func checkChildren() {
        if homeVC.children.count > 2 {
            homeVC.view.subviews[2].removeFromSuperview()
            homeVC.children[2].removeFromParent()
        }
    }
    
    func addDeliveryVC() {
        let deliveryVC = DeliveryViewController()
        let mapsManager = MapsManager()
        let presenter = DeliveryPresenter(view: deliveryVC, mapsManager: mapsManager)
        deliveryVC.inject(presenter: presenter)
        createShadowView()
        if let shadowView = shadowView {
            deliveryVC.view.addSubview(shadowView)
        }
        homeVC.addChild(deliveryVC)
        homeVC.view.addSubview(deliveryVC.view)
        deliveryVC.view.frame = homeVC.view.frame
        deliveryVC.didMove(toParent: homeVC)
    }
    
}
