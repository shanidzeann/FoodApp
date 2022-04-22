//
//  ContainerViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var hasSetFrame = false
    var frame: CGRect!
    
    var sideMenuState: SideMenuState = .closed
    
    let menuVC = SideMenuViewController()
    let homeVC = HomeViewController()
    var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        addChilds()
        addGestureRecognizers()
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
        addMenuVC()
        addHomeVC()
    }
    
    private func addMenuVC() {
        let presenter = SideMenuPresenter()
        menuVC.presenter = presenter
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
    }
    
    private func addHomeVC() {
        homeVC.delegate = self
        let navController = UINavigationController(rootViewController: homeVC)
        addChild(navController)
        view.addSubview(navController.view)
        navController.didMove(toParent: self)
        self.navController = navController
    }
    
    private func addGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        homeVC.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        toggleMenu()
    }
    
}

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
                self.homeVC.menuViewController.moreButton.isUserInteractionEnabled = true
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
        case .delivery:
            addDeliveryVC()
        }
    }
    
    func resetToHome() {
        if homeVC.children.count > 2 {
            homeVC.view.subviews[2].removeFromSuperview()
            homeVC.children[2].removeFromParent()
        }
    }
    
    private func addDeliveryVC() {
        let deliveryVC = DeliveryViewController()
        homeVC.addChild(deliveryVC)
        homeVC.view.addSubview(deliveryVC.view)
        deliveryVC.view.frame = homeVC.view.frame
        deliveryVC.didMove(toParent: homeVC)
    }
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        switch sideMenuState {
        case .opened:
            return true
        case .closed:
            return false
        }
    }
}
