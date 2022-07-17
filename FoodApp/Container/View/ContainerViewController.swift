//
//  ContainerViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 18.04.2022.
//

import UIKit

final class ContainerViewController: UIViewController, ContainerViewProtocol {
    
    // MARK: -  Properties
    
    var presenter: ContainerPresenterProtocol!
    
    var hasSetFrame = false
    var frame: CGRect!
    var safeNavBarFrame: CGRect!
    var sideMenuState: SideMenuState = .closed
    
    var navController: UINavigationController!
    var sideMenuVC: SideMenuViewController!
    var homeVC: HomeViewController!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        createChildren()
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
    
    // MARK: - Injection
    
    func inject(_ presenter: ContainerPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - VC Children
    
    private func createChildren() {
        createSideMenuVC()
        createHomeVC()
    }
    
    private func createSideMenuVC() {
        sideMenuVC = SideMenuViewController()
        let presenter = SideMenuPresenter()
        sideMenuVC.presenter = presenter
        sideMenuVC.delegate = self
    }
    
    private func createHomeVC() {
        homeVC = HomeViewController()
        homeVC.delegate = self
        let navController = UINavigationController(rootViewController: homeVC)
        self.navController = navController
    }
    
    private func addChildren() {
        add(asChildViewController: sideMenuVC)
        add(asChildViewController: navController)
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
        show(createProfileVC(), style: .slide)
    }
    
    @objc private func signOut() {
        show(createLoginVC(), style: .slide)
    }
    
    @objc private func showOrders() {
        navController?.pushViewController(createOrderHistoryVC(), animated: true)
    }
    
    // MARK: - Assembly
    
    func createProfileVC() -> ProfileViewController {
        let profileVC = ProfileViewController()
        let firestoreManager = FirestoreManager()
        let presenter = ProfilePresenter(view: profileVC, databaseManager: firestoreManager)
        profileVC.inject(presenter)
        return profileVC
    }
    
    func createOrderHistoryVC() -> OrderHistoryViewController {
        let orderHistoryVC = OrderHistoryViewController()
        let firestoreManager = FirestoreManager()
        let presenter = OrderHistoryPresenter(view: orderHistoryVC, firestoreManager: firestoreManager)
        orderHistoryVC.inject(presenter)
        return orderHistoryVC
    }
    
    func createLoginVC() -> LoginViewController {
        let loginVC = LoginViewController()
        let firestoreManager = FirestoreManager()
        let authManager = AuthManager(databaseManager: firestoreManager)
        let presenter = LoginPresenter(view: loginVC, authManager: authManager)
        loginVC.inject(presenter)
        return loginVC
    }
    
    func createDeliveryVC() -> DeliveryViewController {
        let deliveryVC = DeliveryViewController()
        let mapsManager = MapsManager()
        let presenter = DeliveryPresenter(view: deliveryVC, mapsManager: mapsManager)
        deliveryVC.inject(presenter: presenter)
        deliveryVC.createNavBarShadowView(frame: safeNavBarFrame)
        return deliveryVC
    }
    
    // MARK: - Routing
    
    func show(_ vc: UIViewController, style: VCPresentationStyle) {
        homeVC.add(asChildViewController: vc)
        switch style {
        case .replace:
            vc.view.frame = homeVC.view.frame
        case .slide:
            self.presentFromRight(vc)
        }
    }
    
    private func presentFromRight(_ vc: UIViewController) {
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
            show(createProfileVC(), style: .replace)
        } else {
            show(createLoginVC(), style: .replace)
        }
    }
    
    private func isUserAuthenticated() -> Bool {
        presenter.isUserAuthenticated()
    }
    
    // MARK: - Private
    
    private func setFrames() {
        hasSetFrame = true
        frame = CGRect(x: 0,
                       y: 0,
                       width: view.frame.size.width,
                       height: view.frame.size.height)
        sideMenuVC.view.frame = CGRect(x: -frame.width * 0.7,
                                   y: frame.minY,
                                   width: frame.width * 0.7,
                                   height: frame.height)
        
        let navBarFrame = navController?.navigationBar.frame
        safeNavBarFrame = CGRect(x: 0,
                                 y: 0,
                                 width: navBarFrame!.width,
                                 height: navBarFrame!.height + view.safeAreaInsets.top)
    }
    
}
