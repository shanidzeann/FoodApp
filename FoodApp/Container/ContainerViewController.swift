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
    var safeNavBarFrame: CGRect!
    
    var shadowView: UIView?
    
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
            let navBarFrame = navController?.navigationBar.frame
            safeNavBarFrame = CGRect(x: 0, y: 0, width: navBarFrame!.width, height: navBarFrame!.height + view.safeAreaInsets.top)
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
    
    func createShadowView() {
        shadowView = UIView(frame: safeNavBarFrame)
        guard let shadowView = shadowView else { return }
        shadowView.backgroundColor = .secondarySystemBackground
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        shadowView.layer.shadowRadius = 2
    }
    
}
