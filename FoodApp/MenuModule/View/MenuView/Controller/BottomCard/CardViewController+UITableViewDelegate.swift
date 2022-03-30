//
//  CardViewController+UITableViewDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 30.03.2022.
//

import UIKit

extension CardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("animateTransitionIfNeeded"), object: nil)
        menu?.showCategory(at: indexPath)
    }
}
