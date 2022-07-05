//
//  ContainerViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import UIKit
import FirebaseAuth

final class ContainerViewController: UIViewController {
    
    // MARK: -  Properties
    
    var hasSetFrame = false
    var frame: CGRect!
    var safeNavBarFrame: CGRect!
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
    
    private func setFrames() {
        hasSetFrame = true
        frame = CGRect(x: 0,
                       y: 0,
                       width: view.frame.size.width,
                       height: view.frame.size.height)
        menuVC.view.frame = CGRect(x: -frame.width * 0.7,
                                   y: frame.minY,
                                   width: frame.width * 0.7,
                                   height: frame.height)
        
        let navBarFrame = navController?.navigationBar.frame
        safeNavBarFrame = CGRect(x: 0,
                                 y: 0,
                                 width: navBarFrame!.width,
                                 height: navBarFrame!.height + view.safeAreaInsets.top)
    }
    
    // MARK: - VC Children
    
    private func addChildren() {
        addMenuVC()
        addHomeVC()
    }
    
    private func addMenuVC() {
        let presenter = SideMenuPresenter()
        menuVC.presenter = presenter
        menuVC.delegate = self
        add(asChildViewController: menuVC)
    }
    
    private func addHomeVC() {
        homeVC.delegate = self
        let navController = UINavigationController(rootViewController: homeVC)
        add(asChildViewController: navController)
        self.navController = navController
    }
    
    // MARK: - Gesture Recognizers
    
    private func addGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        homeVC.view.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        toggleMenu()
    }
    
    // MARK: - Observers
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showProfile),
                                               name: NSNotification.Name("showProfile"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(signOut),
                                               name: NSNotification.Name("signOut"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showOrders),
                                               name: NSNotification.Name("showOrders"),
                                               object: nil)
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
    
    // MARK: - Assembly
    
    func profileVC() -> ProfileViewController {
        let profileVC = ProfileViewController()
        let firestoreManager = FirestoreManager()
        let presenter = ProfilePresenter(view: profileVC, databaseManager: firestoreManager)
        profileVC.inject(presenter)
        return profileVC
    }
    
    func orderHistoryVC() -> OrderHistoryViewController {
        let orderHistoryVC = OrderHistoryViewController()
        let firestoreManager = FirestoreManager()
        let presenter = OrderHistoryPresenter(view: orderHistoryVC, firestoreManager: firestoreManager)
        orderHistoryVC.inject(presenter)
        return orderHistoryVC
    }
    
    func loginVC() -> LoginViewController {
        let loginVC = LoginViewController()
        let firestoreManager = FirestoreManager()
        let authManager = AuthManager(databaseManager: firestoreManager)
        let presenter = LoginPresenter(view: loginVC, authManager: authManager)
        loginVC.inject(presenter)
        return loginVC
    }
    
    func deliveryVC() -> DeliveryViewController {
        let deliveryVC = DeliveryViewController()
        let mapsManager = MapsManager()
        let presenter = DeliveryPresenter(view: deliveryVC, mapsManager: mapsManager)
        deliveryVC.inject(presenter: presenter)
        
        let shadowView = UIView(frame: safeNavBarFrame)
        shadowView.dropShadow(shadowColor: UIColor.lightGray,
                              backgroundColor: .secondarySystemBackground,
                              opacity: 0.8,
                              offSet: CGSize(width: 0, height: 2.0),
                              radius: 2)
        deliveryVC.view.addSubview(shadowView)
        
        return deliveryVC
    }
    
    // MARK: - Routing
    
    func show(_ vc: UIViewController, style: VCPresentationStyle) {
        homeVC.add(asChildViewController: vc)
        let frame = homeVC.view.frame
        switch style {
        case .replace:
            vc.view.frame = homeVC.view.frame
        case .slide:
            vc.view.frame = CGRect(x: frame.maxX,
                                   y: frame.minY,
                                   width: frame.width,
                                   height: frame.height)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                vc.view.frame = self.homeVC.view.frame
            } completion: { _ in
                self.removeUnnecessaryChildIfExists()
            }
        }
    }
    
    func removeUnnecessaryChildIfExists() {
        if !isMenuLastOpened() {
            homeVC.view.subviews[2].removeFromSuperview()
            homeVC.children[2].removeFromParent()
        }
    }
    
    private func isMenuLastOpened() -> Bool {
        homeVC.children.count == 2
    }
    
    func showProfileOrLogin() {
        if isUserAuthenticated() {
            show(profileVC(), style: .replace)
        } else {
            show(loginVC(), style: .replace)
        }
    }
    
    private func isUserAuthenticated() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func resetToHome() {
        navController?.navigationBar.barTintColor = .systemBackground
    }
    
    // MARK: - NavBar Configuration
    
    func hideCartButton(_ isHidden: Bool) {
        navController?.navigationBar.topItem?.rightBarButtonItem = isHidden ? nil : homeVC.cartButton
    }
    
    func changeNavControllerTitle(_ title: String) {
        navController?.navigationBar.topItem?.title = title
    }
    
}
