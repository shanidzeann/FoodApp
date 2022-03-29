//
//  BannerCollectionViewCell.swift
//  FoodApp
//
//  Created by Anna Shanidze on 27.03.2022.
//

import UIKit
import Kingfisher
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 10.0
        ).cgPath
    }
    
    func configure(with image: String) {
        bannerImageView.image = UIImage(named: image)
    }
    
    private func createUI() {
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(bannerImageView)
    }
    
    private func setupConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

}
