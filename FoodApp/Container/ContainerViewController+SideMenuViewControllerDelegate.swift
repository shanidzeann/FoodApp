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
        showSelected(menuItem)
    }
    
    private func showSelected(_ menuItem: MenuOptions) {
        switch menuItem {
        case .home:
            changeNavControllerTitle("")
            resetToHome()
        case .profile:
            hideCartButton(true)
            addProfileVC()
        case .delivery:
            hideCartButton(true)
            changeNavControllerTitle("Доставка")
            addDeliveryVC()
        }
    }
    
    func resetToHome() {
        navController?.navigationBar.barTintColor = .systemBackground
        hideCartButton(false)
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
        
        homeVC.add(deliveryVC)
        deliveryVC.view.frame = homeVC.view.frame
    }
    
    func addProfileVC() {
        let profileVC = ProfileViewController()
        let presenter = ProfilePresenter(view: profileVC)
        profileVC.inject(presenter)
        
        homeVC.add(profileVC)
        profileVC.view.frame = homeVC.view.frame
    }
    
    private func createShadowView() {
        shadowView = UIView(frame: safeNavBarFrame)
        guard let shadowView = shadowView else { return }
        shadowView.backgroundColor = .secondarySystemBackground
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        shadowView.layer.shadowRadius = 2
    }
    
    private func hideCartButton(_ isHidden: Bool) {
        navController?.navigationBar.topItem?.rightBarButtonItem = isHidden ? nil : homeVC.cartButton
    }
    
    private func changeNavControllerTitle(_ title: String) {
        navController?.navigationBar.topItem?.title = title
    }
    
}
