//
//  CardViewController+UITableViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 30.03.2022.
//

import UIKit

extension CardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.CellIdentifiers.cardCell, for: indexPath)
        #warning("presenter")
        let cellText = "\(sections[indexPath.row].title) \(sections[indexPath.row].itemsCount)"
        let itemsCount = "\(sections[indexPath.row].itemsCount)"
        
        let range = (cellText as NSString).range(of: itemsCount)
        
        let attributedString = NSMutableAttributedString(string: cellText)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: range)
        
        cell.textLabel?.attributedText = attributedString
        return cell
    }
}
