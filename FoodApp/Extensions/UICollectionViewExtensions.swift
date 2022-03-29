//
//  UICollectionViewExtensions.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import UIKit

extension UICollectionView  {
    func scrollToSupplementaryView(ofKind kind: String, at indexPath: IndexPath, animated: Bool) {
        self.layoutIfNeeded();
        if let layoutAttributes =  self.layoutAttributesForSupplementaryElement(ofKind: kind, at: indexPath) {
            let viewOrigin = CGPoint(x: layoutAttributes.frame.origin.x, y: layoutAttributes.frame.origin.y);
            var offset : CGPoint = self.contentOffset;
            offset.y = viewOrigin.y - self.contentInset.top
            self.scrollRectToVisible(CGRect(origin: offset, size: self.frame.size), animated: animated)
        }
    }
}
