//
//  PresentationController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import UIKit

class PresentationController: UIPresentationController {
    
    let blurEffectView: UIVisualEffectView
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let frame = containerView?.frame else { return CGRect() }
        return CGRect(origin: CGPoint(x: 0, y: frame.height * 0.4),
               size: CGSize(width: frame.width, height: frame.height * 0.6))
    }
    
    override func presentationTransitionWillBegin() {
        blurEffectView.alpha = 0
        containerView?.addSubview(blurEffectView)
        presentedViewController.transitionCoordinator?.animate { [weak self] _ in
            self?.blurEffectView.alpha = 0.3
        }
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.blurEffectView.alpha = 0
        }, completion: { [weak self] _ in
            self?.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismissController() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
