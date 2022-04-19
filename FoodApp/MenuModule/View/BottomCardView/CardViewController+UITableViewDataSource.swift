//
//  CardViewController+UITableViewDataSource.swift
//  FoodApp
//
//  Created by Anna Shanidze on 30.03.2022.
//

import UIKit

extension CardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.CellIdentifiers.cardCell, for: indexPath)
        
        let attributedString = presenter.cellText(for: indexPath).attributedString
        let range = presenter.cellText(for: indexPath).range
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: range)
        cell.textLabel?.attributedText = attributedString
        
        return cell
    }
}
