//
//  CardPresenter.swift
//  FoodApp
//
//  Created by Anna Shanidze on 19.04.2022.
//

import Foundation

class CardPresenter: CardPresenterProtocol {
    
    var sections = [(title: String, itemsCount: Int)]()

    // MARK: - Init

    required init(sections: [(title: String, itemsCount: Int)]) {
        self.sections = sections
    }
    
    func numberOfRowsInSection() -> Int {
        return sections.count
    }
    
    func cellText(for indexPath: IndexPath) -> (attributedString: NSMutableAttributedString, range: NSRange) {
        let cellText = "\(sections[indexPath.row].title) \(sections[indexPath.row].itemsCount)"
        let itemsCount = "\(sections[indexPath.row].itemsCount)"
        let range = (cellText as NSString).range(of: itemsCount)
        let attributedString = NSMutableAttributedString(string: cellText)
        return (attributedString, range)
    }
    
}
