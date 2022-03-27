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
    
    // MARK: - Properties
    
  //  private var presenter: BannerCellPresenterProtocol!
    
    // MARK: - UI
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .label
        return imageView
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 10.0
        ).cgPath
    }
    
//    func inject(presenter: MenuCellPresenterProtocol) {
//        self.presenter = presenter
//    }
//
//    func configure(with item: MenuItem) {
//        presenter.configure(with: item)
//    }
    
    private func createUI() {
        backgroundColor = .systemBackground
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(bannerImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
    
    override func prepareForReuse() {
        bannerImageView.kf.cancelDownloadTask()
        bannerImageView.kf.setImage(with: URL(string: ""))
        bannerImageView.image = nil
    }

}
