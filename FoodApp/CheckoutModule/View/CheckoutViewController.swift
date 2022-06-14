//
//  CheckoutViewController.swift
//  FoodApp
//
//  Created by Anna Shanidze on 13.06.2022.
//

import UIKit
import SnapKit

class CheckoutViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var presenter: CheckoutPresenterProtocol!
    
    // MARK: - UI
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "КОНТАКТНЫЕ ДАННЫЕ"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Номер телефона"
        return textField
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ваше имя"
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Адрес"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let apartmentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Квартира"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let floorTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Этаж"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let checkAddressButton: UIButton = {
        let button = UIButton(configuration: .filled(), primaryAction: nil)
        button.configuration?.baseBackgroundColor = .systemGreen
        button.setTitle("Проверить адрес", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let sumLabel: UILabel = {
        let label = UILabel()
        label.text = "Сумма заказа"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(configuration: .filled(), primaryAction: nil)
        button.configuration?.baseBackgroundColor = .systemRed
        button.setTitle("Подтвердить заказ", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        addSubviews()
        setupConstraints()
        presenter.getData()
        addTargets()
    }
    
    // MARK: - Injection
    
    func inject(_ presenter: CheckoutPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - UI
    
    private func addSubviews() {
        view.addSubview(dataLabel)
        view.addSubview(phoneTextField)
        view.addSubview(nameTextField)
        view.addSubview(addressTextField)
        view.addSubview(apartmentTextField)
        view.addSubview(floorTextField)
        view.addSubview(errorLabel)
        view.addSubview(checkAddressButton)
        view.addSubview(sumLabel)
        view.addSubview(priceLabel)
        view.addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(20)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(dataLabel.snp.bottom).offset(10)
            make.left.equalTo(dataLabel)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(40.0)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(10)
            make.left.right.height.equalTo(phoneTextField)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.height.left.right.equalTo(phoneTextField)
        }
        
        apartmentTextField.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo((view.frame.width - 40)/2 - 5)
        }
        
        floorTextField.snp.makeConstraints { make in
            make.top.height.equalTo(apartmentTextField)
            make.right.equalToSuperview().inset(20)
            make.left.equalTo(apartmentTextField.snp.right).offset(10)
        }
        
        checkAddressButton.snp.makeConstraints { make in
            make.top.equalTo(apartmentTextField.snp.bottom).offset(10)
            make.left.right.equalTo(errorLabel)
            make.height.equalTo(50.0)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(checkAddressButton.snp.bottom).offset(10)
            make.left.right.equalTo(addressTextField)
        }
        
        sumLabel.snp.makeConstraints { make in
            make.bottom.equalTo(confirmButton.snp.top).inset(-20.0)
            make.left.equalToSuperview().inset(20.0)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(sumLabel)
            make.right.equalToSuperview().inset(20.0)
            make.left.greaterThanOrEqualTo(sumLabel.snp.right).inset(10)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(20.0)
            make.height.equalTo(50.0)
        }
        
    }
    
    // MARK: - Actions
    
    private func addTargets() {
        checkAddressButton.addTarget(self, action: #selector(checkAddress), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmOrder), for: .touchUpInside)
    }
    
    @objc private func checkAddress() {
        presenter.check(addressTextField.text!) { [weak self] passed, message  in
            self?.errorLabel.text = message
        }
    }
    
    @objc private func confirmOrder() {
        let name = nameTextField.text!
        let phone = phoneTextField.text!
        let address = addressTextField.text!
        let apartment = apartmentTextField.text!
        let floor = floorTextField.text!
        let order = Order(menuItems: nil, userID: nil, address: address, apartment: apartment, floor: floor, date: nil, totalPrice: nil, userName: name, userPhone: phone)
        presenter.checkout(order)
    }

}
