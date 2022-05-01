//
//  UIViewControlle+addChild.swift
//  FoodApp
//
//  Created by Anna Shanidze on 01.05.2022.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
