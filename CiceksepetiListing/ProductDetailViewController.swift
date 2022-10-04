//
//  ProductDetailViewController.swift
//  CiceksepetiListing
//
//  Created by Berkan Korkmaz on 12.09.2022.
//

import UIKit
import SnapKit

class ProductDetailViewController: UIViewController {
    
    lazy var imageViewDetail: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        return imageView
    }()
    
    lazy var urunAdiLabelDetail: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Ürün Adı"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var siparisVerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Sipariş Ver", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(sipButtonAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    var products:Products?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Product Detail"
        
        setupView()
        
        if let f = products {
            if let url = URL(string: "\(f.image!)"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.imageViewDetail.image = UIImage(data: data!)
                    }
                }
            }
            urunAdiLabelDetail.text = f.name
        }
    }
    
    @objc func sipButtonAction(sender: UIButton) {
        showToast(message: "Siparişiniz alınmıştır...", seconds: 1.0)
    }
}

extension ProductDetailViewController {
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(urunAdiLabelDetail)
        view.addSubview(imageViewDetail)
        view.addSubview(siparisVerButton)
        
        imageViewDetail.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(2.2)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        urunAdiLabelDetail.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(imageViewDetail.snp.bottom).offset(20)
        }
        
        siparisVerButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(120)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.height.equalTo(50)
        }
    }
    
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}

