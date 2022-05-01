//
//  HomeViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 26.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var collectionViewPanGestureEnabled = false
    var scrolledToTop = false
    
    var menuViewController: MenuViewController!
    var bannerViewController: BannerViewController!
    
    private var visualEffectView: UIVisualEffectView!
    private var state: MenuState = .collapsed
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    private var fractionComplete: CGFloat = 0
    private let duration: TimeInterval = 0.9
    private let dampingRatio: CGFloat = 1
    
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
            animateTransitionIfNeeded()
        }
    }
    
    @objc func animateTransitionBeforeSideMenu() {
        if state == .expanded {
            animateTransitionIfNeeded()
        }
    }
    
    // MARK: - UI
    
    private func createUI() {
        view.backgroundColor = .secondarySystemBackground
        createBanner()
        createMenu()
        createVisualEffectView()
        configureNavBar()
    }
    
    private func createBanner() {
        bannerViewController = BannerViewController()
        let presenter = BannerPresenter()
        bannerViewController.presenter = presenter
        
        add(bannerViewController)
    }
    
    private func createMenu() {
        menuViewController = MenuViewController()
        let jsonParser = JSONParser()
        let networkManager = NetworkManager(jsonParser: jsonParser)
        let presenter = MenuPresenter(networkManager: networkManager)
        menuViewController.presenter = presenter
        
        add(menuViewController)
    }
    
    private func createVisualEffectView() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        bannerViewController.view.addSubview(visualEffectView)
        visualEffectView.isUserInteractionEnabled = false
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
            startInteractiveTransition()
        case .changed:
            calculateFractionComplete(recognizer: recognizer)
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            reverseAnimation(recognizer: recognizer)
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func startInteractiveTransition() {
        animateTransitionIfNeeded()
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func animateTransitionIfNeeded() {
        if runningAnimations.isEmpty {
            addFrameAnimator()
            addBlurAnimator()
        }
    }
    
    private func calculateFractionComplete(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: menuViewController.menuCollectionView)
        fractionComplete = translation.y / (view.bounds.height/5)
        fractionComplete = state == .expanded ? fractionComplete : -fractionComplete
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
    
    private func addFrameAnimator() {
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: dampingRatio) {
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
                self.state.toggle()
            }
            self.runningAnimations.removeAll()
        }
        
        frameAnimator.startAnimation()
        runningAnimations.append(frameAnimator)
    }
    
    private func addBlurAnimator() {
        let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: dampingRatio) {
            switch self.state {
            case .expanded:
                self.visualEffectView.effect = nil
            case .collapsed:
                self.visualEffectView.effect = UIBlurEffect(style: .dark)
            }
        }
        
        visualEffectView.alpha = 0.1
        blurAnimator.startAnimation()
        runningAnimations.append(blurAnimator)
    }
}

