//
//  HomeViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 26.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var gestureEnabled = false
    var scrolledToTop = false
    
    var menuViewController: MenuViewController!
    var bannerViewController: BannerViewController!
    var visualEffectVuew: UIVisualEffectView!
    
    var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0

    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        addObservers()
        setGestureRecognizers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bannerViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/4)
        menuViewController.view.frame = CGRect(x: 0, y: view.frame.height/4, width: view.bounds.width, height: view.bounds.height -  view.safeAreaInsets.top)
    }
    
    // MARK: - Observers
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(enablePanGestureRecognizer), name: NSNotification.Name("enableHomePanGestureRecognizer"), object: nil)
    }
    
    @objc func enablePanGestureRecognizer() {
        scrolledToTop = true
    }
    
    // MARK: - UI
    
    private func createUI() {
        view.backgroundColor = .secondarySystemBackground
        
        bannerViewController = BannerViewController()
        addChild(bannerViewController)
        view.addSubview(bannerViewController.view)
        bannerViewController.didMove(toParent: self)
        
        visualEffectVuew = UIVisualEffectView()
        visualEffectVuew.frame = view.frame
        
        menuViewController = MenuViewController()
        let networkManager = NetworkManager()
        let presenter = MenuPresenter(view: menuViewController, networkManager: networkManager)
        menuViewController.presenter = presenter
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParent: self)
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
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: menuViewController.menuCollectionView)
            var fractionComplete = translation.y / (view.bounds.height/4)
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.menuViewController.view.frame.origin.y = self.view.safeAreaInsets.top
                    self.gestureEnabled = true
                    self.scrolledToTop = false
                case .collapsed:
                    self.menuViewController.view.frame.origin.y = self.view.frame.height/4
                    self.gestureEnabled = false
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.bannerViewController.view.addSubview(self.visualEffectVuew)
                    self.visualEffectVuew.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectVuew.effect = nil
                    self.visualEffectVuew.removeFromSuperview()
                }
            }
            
            visualEffectVuew.alpha = 0.1
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
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
}
