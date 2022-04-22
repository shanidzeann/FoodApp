//
//  ContainerViewController+HomeViewControllerDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import UIKit

extension ContainerViewController: HomeViewControllerDelegate {
    func showSideMenu() {
        toggleMenu()
    }
    
    func toggleMenu() {
        NotificationCenter.default.post(name: NSNotification.Name("animateTransitionBeforeSideMenu"), object: nil)
        switch sideMenuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.menuVC.view.frame.origin.x = 0
                self.navController?.view.frame.origin.x = self.frame.size.width * 0.75
                self.navController?.view.frame.origin.y = self.frame.size.height * 0.05
                self.navController?.view.frame.size.height = self.frame.size.height * 0.9
                
                self.shadowView?.frame.origin.x = self.safeNavBarFrame.size.width * 0.75
                self.shadowView?.frame.origin.y = self.safeNavBarFrame.size.height * 0.05
                self.shadowView?.frame.size.height = self.safeNavBarFrame.size.height * 0.9
                
                self.homeVC.bannerViewController.collectionView?.collectionViewLayout.invalidateLayout()
                self.homeVC.menuViewController.moreButton.isUserInteractionEnabled = false
            } completion: { [weak self] done in
                if done {
                    self?.sideMenuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.menuVC.view.frame.origin.x = -self.frame.width * 0.7
                self.navController?.view.frame.origin.x = 0
                self.navController?.view.frame.origin.y = 0
                self.navController?.view.frame.size.height = self.frame.size.height
                
                self.shadowView?.frame.origin.x = 0
                self.shadowView?.frame.origin.y = 0
                self.shadowView?.frame.size.height = self.safeNavBarFrame.size.height
                
                self.homeVC.menuViewController.moreButton.isUserInteractionEnabled = true
            } completion: { [weak self] done in
                self?.sideMenuState = .closed
            }
        }
    }
}
