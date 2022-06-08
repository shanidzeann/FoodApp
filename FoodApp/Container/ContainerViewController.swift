//
//  ContainerViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    // MARK: -  Properties
    
    var hasSetFrame = false
    var frame: CGRect!
    var safeNavBarFrame: CGRect!
    var shadowView: UIView?
    var sideMenuState: SideMenuState = .closed
    
    let menuVC = SideMenuViewController()
    let homeVC = HomeViewController()
    var navController: UINavigationController?
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        addChilds()
        addGestureRecognizers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showProfile), name: NSNotification.Name("showProfile"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSetFrame {
            hasSetFrame = true
            frame = CGRect(x: 0,
                           y: 0,
                           width: view.frame.size.width,
                           height: view.frame.size.height)
            let navBarFrame = navController?.navigationBar.frame
            safeNavBarFrame = CGRect(x: 0,
                                     y: 0,
                                     width: navBarFrame!.width,
                                     height: navBarFrame!.height + view.safeAreaInsets.top)
            menuVC.view.frame = CGRect(x: -frame.width * 0.7,
                                       y: frame.minY,
                                       width: frame.width * 0.7,
                                       height: frame.height)
        }
    }
    
    // MARK: - Private
    
    private func addChilds() {
        addMenuVC()
        addHomeVC()
    }
    
    private func addMenuVC() {
        let presenter = SideMenuPresenter()
        menuVC.presenter = presenter
        menuVC.delegate = self
        add(menuVC)
    }
    
    private func addHomeVC() {
        homeVC.delegate = self
        let navController = UINavigationController(rootViewController: homeVC)
        add(navController)
        self.navController = navController
    }
    
    private func addGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        homeVC.view.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        toggleMenu()
    }
    
    @objc private func showProfile() {
        let profileVC = ProfileViewController()
        let presenter = ProfilePresenter(view: profileVC, authManager: AuthManager())
        profileVC.inject(presenter)
        
        homeVC.add(profileVC)
        profileVC.view.frame = CGRect(x: homeVC.view.frame.maxX, y: homeVC.view.frame.minY, width: homeVC.view.frame.width, height: homeVC.view.frame.height)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            profileVC.view.frame = self.homeVC.view.frame
        } completion: { done in
            self.checkChildren()
        }
    }
    
}
