//
//  DeliveryAlert.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.04.2022.
//

import UIKit

class DeliveryAlert {
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .clear
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        alert.alpha = 0
        return alert
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Доставка по указанному адресу не осуществляется"
        return label
    }()
    
    func showAlert(on viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        
        createAlert(on: targetView)
        
        UIView.animate(withDuration: 0.5) {
            self.backgroundView.alpha = 0.2
            self.alertView.alpha = 1
        } completion: { _ in
            self.hideAlert()
        }
    }
    
    private func hideAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.5) {
                self.backgroundView.alpha = 0
                self.alertView.alpha = 0
            } completion: { _ in
                self.alertView.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
            }
        }
    }
    
    func createAlert(on targetView: UIView) {
        backgroundView.frame = targetView.bounds
        
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        
        let alertViewWidth = targetView.frame.size.width * 0.8
        
        alertView.frame = CGRect(x: targetView.center.x - alertViewWidth/2,
                                 y: targetView.center.y - 25,
                                 width: alertViewWidth,
                                 height: 70)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = alertView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alertView.addSubview(blurEffectView)
        
        messageLabel.frame = alertView.bounds
        alertView.addSubview(messageLabel)
    }
    
}
