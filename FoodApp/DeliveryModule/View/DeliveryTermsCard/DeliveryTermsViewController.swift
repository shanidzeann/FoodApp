//
//  DeliveryTermsViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.04.2022.
//

import UIKit

class DeliveryTermsViewController: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    private let slideIdicator = UIView()
    private let panGestureView = UIView()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Тут будут условия доставки"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setGestureRecognizer()
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = view.frame.origin
        }
        slideIdicator.layer.cornerRadius = 2.5
    }
    
    private func configureViews() {
        slideIdicator.backgroundColor = UIColor.darkGray
        view.backgroundColor = .systemBackground
    }
    
    private func setGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        panGestureView.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        guard translation.y >= 0 else { return }
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let velocity = sender.velocity(in: view)
            if velocity.y >= 500 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    private func setupConstraints() {
        view.addSubview(label)
        view.addSubview(panGestureView)
        view.addSubview(slideIdicator)
        
        panGestureView.translatesAutoresizingMaskIntoConstraints = false
        panGestureView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        panGestureView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        panGestureView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        panGestureView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        slideIdicator.translatesAutoresizingMaskIntoConstraints = false
        slideIdicator.centerXAnchor.constraint(equalTo: panGestureView.centerXAnchor).isActive = true
        slideIdicator.centerYAnchor.constraint(equalTo: panGestureView.centerYAnchor).isActive = true
        slideIdicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
        slideIdicator.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}



