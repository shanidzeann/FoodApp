//
//  ProfileViewController+UITableViewDelegate.swift
//  FoodApp
//
//  Created by Anna Shanidze on 08.06.2022.
//

import UIKit
import FirebaseAuth

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selected = presenter.itemForRow(at: indexPath) else { return }
        
        switch selected {
        case .orders:
            NotificationCenter.default.post(name: NSNotification.Name("showOrders"), object: nil)
        case .exit:
            signOut()
        }
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            NotificationCenter.default.post(name: NSNotification.Name("signOut"), object: nil)
        } catch {
            print(error)
        }
    }
}
