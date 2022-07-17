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
            openMenu()
        case .opened:
            closeMenu()
        }
    }
    
    private func openMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.animateSideMenu(menuX: 0, vcX: 0.75, vcY: 0.05, vcHeight: 0.9)
            self.homeVC.bannerViewController.collectionView?.collectionViewLayout.invalidateLayout()
        } completion: { _ in
            self.menuAnimationCompletion(isMenuOpened: true)
        }
    }
    
    private func closeMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.animateSideMenu(menuX: -0.7, vcX: 0, vcY: 0, vcHeight: 1)
        } completion: { _ in
            self.menuAnimationCompletion(isMenuOpened: false)
        }
    }
    
    private func animateSideMenu(menuX: Double, vcX: Double, vcY: Double, vcHeight: Double) {
        sideMenuVC.view.frame.origin.x = frame.width * menuX
        navController?.view.frame = CGRect(x: frame.width * vcX,
                                           y: frame.height * vcY,
                                           width: frame.width,
                                           height: frame.height * vcHeight)
    }
    
    private func menuAnimationCompletion(isMenuOpened: Bool) {
        homeVC.menuViewController.moreButton.isUserInteractionEnabled = !isMenuOpened
        sideMenuState.toggle()
    }
    
}
