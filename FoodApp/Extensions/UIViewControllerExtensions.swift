//
//  UIViewControllerExtensions.swift
//  FoodApp
//
//  Created by Anna Shanidze on 01.05.2022.
//

import UIKit

extension UIViewController {
    func add(asChildViewController child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}

extension UIViewController {
    func show(_ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}

extension UIViewController {
    func createNavBarShadowView(frame: CGRect) {
        let shadowView = UIView(frame: frame)
        shadowView.dropShadow(shadowColor: UIColor.lightGray,
                              backgroundColor: .secondarySystemBackground,
                              opacity: 0.8,
                              offSet: CGSize(width: 0, height: 2.0),
                              radius: 2)
        view.addSubview(shadowView)
    }
}
