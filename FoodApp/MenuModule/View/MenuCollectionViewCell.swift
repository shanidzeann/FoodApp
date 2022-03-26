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
    
    // MARK: - UI
    
    private let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.backgroundColor = .yellow
        label.text = "food"
        return label
    }()
    
    private let desctiptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .green
        label.text = "fjskjdjskdjskdjskdjkjkjkjkjkkjkjkjkjkjkjskdjskdjskdjskdj"
        return label
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        button.backgroundColor = .orange
        button.setTitle("560 р", for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    func inject(presenter: MenuCellPresenterProtocol) {
        self.presenter = presenter
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
            make.left.top.bottom.equalToSuperview().inset(10)
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
            make.height.equalToSuperview().dividedBy(4)
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
 
}
