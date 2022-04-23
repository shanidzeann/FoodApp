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
                self.animateMenu(menuX: 0, vcX: 0.75, vcY: 0.05, vcHeight: 0.9)
                self.homeVC.bannerViewController.collectionView?.collectionViewLayout.invalidateLayout()
            } completion: { [weak self] done in
                if done {
                    self?.menuAnimationCompletion(isOpened: true)
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.animateMenu(menuX: -0.7, vcX: 0, vcY: 0, vcHeight: 1)
            } completion: { [weak self] done in
                self?.menuAnimationCompletion(isOpened: false)
            }
        }
    }
    
    private func animateMenu(menuX: Double, vcX: Double, vcY: Double, vcHeight: Double) {
        menuVC.view.frame.origin.x = frame.width * menuX
        navController?.view.frame = CGRect(x: frame.size.width * vcX,
                           y: frame.size.height * vcY,
                           width: frame.size.width,
                           height: frame.size.height * vcHeight)
        shadowView?.frame = CGRect(x: safeNavBarFrame.size.width * vcX,
                                     y: safeNavBarFrame.size.height * vcY,
                                     width: safeNavBarFrame.size.width,
                                     height: safeNavBarFrame.size.height * vcHeight)
    }
    
    private func menuAnimationCompletion(isOpened: Bool) {
        homeVC.menuViewController.moreButton.isUserInteractionEnabled = !isOpened
        sideMenuState.toggle()
    }
}
