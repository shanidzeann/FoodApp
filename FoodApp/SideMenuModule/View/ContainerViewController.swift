//
//  ContainerViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum SideMenuState {
        case opened
        case closed
    }
    
    var hasSetFrame = false
    var frame: CGRect!
    
    private var sideMenuState: SideMenuState = .closed
    
    let menuVC = SideMenuViewController()
    let homeVC = HomeViewController()
    var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        addChilds()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSetFrame {
            hasSetFrame = true
            frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            
            menuVC.view.frame = CGRect(x: -frame.width * 0.7, y: frame.minY, width: frame.width * 0.7, height: frame.height)
        }
    }
    
    private func addChilds() {
        
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let navController = UINavigationController(rootViewController: homeVC)
        addChild(navController)
        view.addSubview(navController.view)
        navController.didMove(toParent: self)
        self.navController = navController
    }
    
}

extension ContainerViewController: HomeViewControllerDelegate {
    func showSideMenu() {
        toggleMenu()
    }
    
    func toggleMenu() {
        switch sideMenuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.menuVC.view.frame.origin.x = 0
                self.navController?.view.frame.origin.x = self.frame.size.width * 0.75
                self.navController?.view.frame.origin.y = self.frame.size.height * 0.05
                self.navController?.view.frame.size.height = self.frame.size.height * 0.9
                self.homeVC.bannerViewController.collectionView?.collectionViewLayout.invalidateLayout()
                // interactive?
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
              //  self.homeVC.bannerViewController.collectionView?.collectionViewLayout.invalidateLayout()
                
            } completion: { [weak self] done in
                self?.sideMenuState = .closed
            }
            
        }
    }
}

extension ContainerViewController: SideMenuViewControllerDelegate {
    func didSelect(menuItem: MenuOptions) {
        toggleMenu()
        switch menuItem {
        case .home:
            resetToHome()
        case .profile:
            break
        }
    }
    
    func resetToHome() {
        //remove from superview, did move to parent nil
    }
}












