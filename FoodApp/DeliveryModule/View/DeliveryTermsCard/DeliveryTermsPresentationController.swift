//
//  DeliveryTermsPresentationController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.04.2022.
//

import UIKit

final class DeliveryTermsPresentationController: PresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let frame = containerView?.frame else { return CGRect() }
        return CGRect(origin: CGPoint(x: 0, y: frame.height * 0.7),
               size: CGSize(width: frame.width, height: frame.height * 0.3))
    }
}
