//
//  HomeViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 26.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    enum MenuState {
        case expanded
        case collapsed
        
        var change: MenuState {
            switch self {
            case .expanded: return .collapsed
            case .collapsed: return .expanded
            }
        }
    }
    
    var collectionViewPanGestureEnabled = false
    var scrolledToTop = false
    
    var menuViewController: MenuViewController!
    var bannerViewController: BannerViewController!
    private var visualEffectVuew: UIVisualEffectView!

    private var state: MenuState = .collapsed
    
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    private var fractionComplete: CGFloat = 0
    
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        addObservers()
        setGestureRecognizers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bannerViewController.view.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height/5)
        menuViewController.view.frame = CGRect(x: 0, y: view.bounds.height/5 + view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Observers
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(enablePanGestureRecognizer), name: NSNotification.Name("enableHomePanGestureRecognizer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(animateTransition), name: NSNotification.Name("animateTransitionIfNeeded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(animateTransitionBeforeSideMenu), name: NSNotification.Name("animateTransitionBeforeSideMenu"), object: nil)
    }
    
    @objc func enablePanGestureRecognizer() {
        scrolledToTop = true
    }
    
    @objc func animateTransition() {
        if !collectionViewPanGestureEnabled {
            animateTransitionIfNeeded(duration: 0.9)
        }
    }
    
    @objc func animateTransitionBeforeSideMenu() {
        if state == .expanded {
            animateTransitionIfNeeded(duration: 0.9)
        }
    }
    
    // MARK: - UI
    
    private func createUI() {
        view.backgroundColor = .secondarySystemBackground
        visualEffectVuew = UIVisualEffectView()
        visualEffectVuew.frame = view.frame
        createBanner()
        createMenu()
        configureNavBar()
    }
    
    private func createBanner() {
        bannerViewController = BannerViewController()
        let presenter = BannerPresenter()
        bannerViewController.presenter = presenter
        addChild(bannerViewController)
        view.addSubview(bannerViewController.view)
        bannerViewController.didMove(toParent: self)
    }
    
    private func createMenu() {
        menuViewController = MenuViewController()
        let networkManager = NetworkManager()
        let presenter = MenuPresenter(networkManager: networkManager)
        menuViewController.presenter = presenter
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParent: self)
    }
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "text.justify.left"),
            style: .plain,
            target: self,
            action: #selector(didTapSideMenu)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: .plain,
            target: self,
            action: #selector(showShoppingCart)
        )
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func didTapSideMenu() {
        delegate?.showSideMenu()
    }
    
    @objc private func showShoppingCart() {
        let cartVC = CartViewController()
        let databaseManager = DatabaseManager.shared
        let cartPresenter = CartPresenter(view: cartVC, databaseManager: databaseManager)
        cartVC.presenter = cartPresenter
        
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    // MARK: - PanGestureRecognizer
    
    private func setGestureRecognizers() {
        let menuPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleMenuPan(recognizer:)))
        menuPanGestureRecognizer.delegate = self
        
        let categoriesPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleMenuPan(recognizer:)))
        categoriesPanGestureRecognizer.delegate = self
        
        menuViewController.menuCollectionView?.addGestureRecognizer(menuPanGestureRecognizer)
        menuViewController.categoriesCollectionView?.addGestureRecognizer(categoriesPanGestureRecognizer)
    }
    
    @objc func handleMenuPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: menuViewController.menuCollectionView)
            fractionComplete = translation.y / (view.bounds.height/5)
            fractionComplete = state == .expanded ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            reverseAnimation(recognizer: recognizer)
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func startInteractiveTransition(duration: TimeInterval) {
        animateTransitionIfNeeded(duration: duration)
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func animateTransitionIfNeeded(duration: TimeInterval) {
        if runningAnimations.isEmpty {
            addFrameAnimator(duration: duration)
            addBlurAnimator(duration: duration)
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    private func reverseAnimation(recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: menuViewController.categoriesCollectionView)
        let shouldComplete = velocity.y > 0
        
        if velocity.y == 0 {
            continueInteractiveTransition()
            return
        }
        
        for animator in runningAnimations {
            switch state {
            case .expanded:
                if !shouldComplete && !animator.isReversed { animator.isReversed = !animator.isReversed }
                if shouldComplete && animator.isReversed { animator.isReversed = !animator.isReversed }
            case .collapsed:
                if shouldComplete && !animator.isReversed { animator.isReversed = !animator.isReversed }
                if !shouldComplete && animator.isReversed { animator.isReversed = !animator.isReversed }
            }
        }
    }
    
    private func addFrameAnimator(duration: TimeInterval) {
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch self.state {
            case .expanded:
                self.menuViewController.view.frame.origin.y = self.view.frame.height/5 + self.view.safeAreaInsets.top
            case .collapsed:
                self.menuViewController.view.frame.origin.y = self.view.safeAreaInsets.top
            }
        }
        
        frameAnimator.addCompletion { position in
            if position == .end {
                switch self.state {
                case .expanded:
                    self.collectionViewPanGestureEnabled = false
                case .collapsed:
                    self.collectionViewPanGestureEnabled = true
                    self.scrolledToTop = false
                }
                self.state = self.state.change
            }
            self.runningAnimations.removeAll()
        }
        
        frameAnimator.startAnimation()
        runningAnimations.append(frameAnimator)
    }
    
    private func addBlurAnimator(duration: TimeInterval) {
        let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch self.state {
            case .expanded:
                self.visualEffectVuew.effect = nil
                self.visualEffectVuew.removeFromSuperview()
            case .collapsed:
                self.bannerViewController.view.addSubview(self.visualEffectVuew)
                self.visualEffectVuew.effect = UIBlurEffect(style: .dark)
            }
        }
        
        visualEffectVuew.alpha = 0.1
        blurAnimator.startAnimation()
        runningAnimations.append(blurAnimator)
    }
}

