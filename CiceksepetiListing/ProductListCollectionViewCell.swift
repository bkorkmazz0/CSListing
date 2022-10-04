//
//  ProductListCollectionViewCell.swift
//  CiceksepetiListing
//
//  Created by Berkan Korkmaz on 12.09.2022.
//

import UIKit
import SnapKit

class ProductListCollectionViewCell: UICollectionViewCell {

    static let identifier = "ProductListCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    lazy var favoritesImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "favorites"))
        //imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    lazy var cargoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Bugün / Ücretsiz Teslimat"
        label.textColor = UIColor(named: "myColorGreen")
        label.textAlignment = .left
        label.numberOfLines = 1
        label.accessibilityIdentifier = "cargoBerkanLabel"
        return label
    }()
    
    lazy var urunAdiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.text = "Ürün Adı"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var urunFiyatiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.text = "Ürün Fiyatı"
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellSetting()
    }
        
    func cellSetting() {
        self.backgroundColor = .gray
        self.addSubview(imageView)
        imageView.addSubview(favoritesImageView)
        self.addSubview(cargoLabel)
        self.addSubview(urunAdiLabel)
        self.addSubview(urunFiyatiLabel)
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalToSuperview().offset(2)
            make.height.equalToSuperview().dividedBy(1.6)
        }
        
        favoritesImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        cargoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        
        urunAdiLabel.snp.makeConstraints { make in
            make.top.equalTo(cargoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(5)
        }
        
        urunFiyatiLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
