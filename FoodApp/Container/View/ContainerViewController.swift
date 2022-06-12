//
//  ContainerViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import UIKit
import FirebaseAuth

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
        
        addChildren()
        addGestureRecognizers()
        
        addObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSetFrame {
            setFrames()
        }
    }
    
    // MARK: - Private
    
    private func addChildren() {
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
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(showProfile), name: NSNotification.Name("showProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signOut), name: NSNotification.Name("signOut"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showOrders), name: NSNotification.Name("showOrders"), object: nil)
    }
    
    @objc private func showProfile() {
        show(profileVC(), style: .slide)
    }
    
    @objc private func signOut() {
        show(loginVC(), style: .slide)
    }
    
    @objc private func showOrders() {
        navController?.pushViewController(orderHistoryVC(), animated: true)
    }
    
    private func setFrames() {
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
    
    // MARK: - Assembly
    
    func profileVC() -> ProfileViewController {
        let profileVC = ProfileViewController()
        let presenter = ProfilePresenter(view: profileVC, authManager: AuthManager())
        profileVC.inject(presenter)
        return profileVC
    }
    
    func orderHistoryVC() -> OrderHistoryViewController {
        let orderHistoryVC = OrderHistoryViewController()
        let presenter = OrderHistoryPresenter(view: orderHistoryVC)
        orderHistoryVC.inject(presenter)
        return orderHistoryVC
    }
    
    func loginVC() -> LoginViewController {
        let loginVC = LoginViewController()
        let presenter = LoginPresenter(view: loginVC, authManager: AuthManager())
        loginVC.inject(presenter)
        return loginVC
    }
    
    func deliveryVC() -> DeliveryViewController {
        let deliveryVC = DeliveryViewController()
        let mapsManager = MapsManager()
        let presenter = DeliveryPresenter(view: deliveryVC, mapsManager: mapsManager)
        deliveryVC.inject(presenter: presenter)
        
        createShadowView()
        if let shadowView = shadowView {
            deliveryVC.view.addSubview(shadowView)
        }
        return deliveryVC
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
    
    // MARK: - Routing
    
    func show(_ vc: UIViewController, style: VCPresentationStyle) {
        switch style {
        case .replace:
            homeVC.add(vc)
            vc.view.frame = homeVC.view.frame
        case .slide:
            homeVC.add(vc)
            vc.view.frame = CGRect(x: homeVC.view.frame.maxX, y: homeVC.view.frame.minY, width: homeVC.view.frame.width, height: homeVC.view.frame.height)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                vc.view.frame = self.homeVC.view.frame
            } completion: { done in
                self.checkChildren()
            }
        }
    }
    
    func resetToHome() {
        navController?.navigationBar.barTintColor = .systemBackground
    }
    
    func checkChildren() {
        if homeVC.children.count > 2 {
            homeVC.view.subviews[2].removeFromSuperview()
            homeVC.children[2].removeFromParent()
        }
    }
    
    func checkUser() {
        if Auth.auth().currentUser == nil {
            show(loginVC(), style: .replace)
        } else {
            show(profileVC(), style: .replace)
        }
    }
    
    // MARK: - NavBar Configuration
    
    func hideCartButton(_ isHidden: Bool) {
        navController?.navigationBar.topItem?.rightBarButtonItem = isHidden ? nil : homeVC.cartButton
    }
    
    func changeNavControllerTitle(_ title: String) {
        navController?.navigationBar.topItem?.title = title
    }
    
}
