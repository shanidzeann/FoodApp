//
//  MenuCollectionViewCell.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var presenter: MenuCellPresenterProtocol!
    var delegate: MenuViewController?
    var callback: (() -> Void)?
    
    // MARK: - UI
    
    private let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.text = "Food"
        return label
    }()
    
    private let desctiptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "nyam"
        return label
    }()
    
    private var priceButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.backgroundColor = .secondarySystemBackground
        button.clipsToBounds = true
        button.configuration?.baseForegroundColor = .label
        button.layer.cornerRadius = 5
   //     button.configuration?.attributedSubtitle?.font = .systemFont(ofSize: 8)
        button.setTitle("374 р", for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        configureView()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 10.0
        ).cgPath
    }
    
    // MARK: - Helper Methods
    
    func inject(presenter: MenuCellPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with item: MenuItem) {
        presenter.configure(with: item)
    }
    
    private func addTargets() {
        priceButton.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
    }
    
    @objc private func didTapBuy() {
      //  animateView(sender)
        presenter.addToCart()
        callback?()
    }
    
    private func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
        
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func createUI() {
        contentView.addSubview(menuImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(desctiptionLabel)
        contentView.addSubview(priceButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        menuImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(menuImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(menuImageView.snp.right).offset(10)
            make.top.right.equalToSuperview().inset(10)
        }
        
        desctiptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(titleLabel)
        }
        
        priceButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(desctiptionLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalTo(titleLabel)
            make.height.equalToSuperview().dividedBy(3.6)
            make.width.equalTo(priceButton.snp.height).multipliedBy(2.5)
        }
        
    }
    
    override func prepareForReuse() {
        menuImageView.kf.cancelDownloadTask()
        menuImageView.kf.setImage(with: URL(string: ""))
        menuImageView.image = nil
    }
    
}


// MARK: -  MovieCellProtocol
extension MenuCollectionViewCell: MenuCellProtocol {
    func setData(title: String, description: String, price: String, imageURL: URL?, subtitle: String?) {
        titleLabel.text = title
        desctiptionLabel.text = description
        priceButton.setTitle(price, for: .normal)
        priceButton.configuration?.subtitle = subtitle
        priceButton.configuration?.attributedSubtitle?.font = .systemFont(ofSize: 8)
        
        menuImageView.kf.setImage(with: imageURL) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.menuImageView.image = UIImage(systemName: "fork.knife.circle")
                self.menuImageView.tintColor = .black
            }
        }
    }
    
    func reloadData() {
        // обновить картинку корзины?
    }
}
