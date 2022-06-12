//
//  OrderHistoryViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 12.06.2022.
//

import UIKit

class OrderHistoryViewController: UIViewController, OrderHistoryViewProtocol {
    
    private var presenter: OrderHistoryPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
    
    func inject(_ presenter: OrderHistoryPresenterProtocol) {
        self.presenter = presenter
    }
    
}
