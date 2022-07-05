//
//  CardViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 29.03.2022.
//

import UIKit
import SnapKit

final class CardViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CardPresenterProtocol!
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    weak var delegate: CardViewControllerDelegate?
    
    // MARK: - UI
    
    private let slideIdicator = UIView()
    private let panGestureView = UIView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableView.CellIdentifiers.cardCell)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureTableView()
        setupConstraints()
        setGestureRecognizer()
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = view.frame.origin
        }
        slideIdicator.layer.cornerRadius = 2.5
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(panGestureView)
        view.addSubview(slideIdicator)
        view.addSubview(tableView)
    }
    
    private func configureViews() {
        slideIdicator.backgroundColor = UIColor.darkGray
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        panGestureView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        slideIdicator.snp.makeConstraints { make in
            make.center.equalTo(panGestureView)
            make.height.equalTo(5)
            make.width.equalTo(70)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(panGestureView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - GestureRecognizer
    
    private func setGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        panGestureView.addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        guard translation.y >= 0 else { return }
        view.frame.origin = CGPoint(x: 0, y: pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let velocity = sender.velocity(in: view)
            if velocity.y >= 1300 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
}
