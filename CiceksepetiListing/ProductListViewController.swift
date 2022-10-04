//
//  ProductListViewController.swift
//  CiceksepetiListing
//
//  Created by Berkan Korkmaz on 12.09.2022.
//

import UIKit
import Alamofire
import SnapKit

class ProductListViewController: UIViewController {
    
    lazy var searchBar:UISearchBar = {
        let search =  UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        search.placeholder = "Marka, ürün veya kategori ara"
        search.sizeToFit()
        return search
    }()
    
    let whereToView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var whereToViewLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.text = "Gönderim Yeri Seçin"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var whereToViewImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "location")
        return image
    }()

    lazy var filterView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var filterViewLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.text = "Filtrele"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var filterViewImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "filter")
        return image
    }()
    
    lazy var sortViewLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.text = "Sırala"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var sortViewImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sort")
        return image
    }()
    
    private var lastContentOffset: CGFloat = 0
    var urunListesi = [Products]()
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var productListCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //deneme
        setupUI()
        loadJsonData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.filterView.alpha = 1.0
                self?.filterView.transform = CGAffineTransform(translationX: 0, y: 0)
                self?.whereToView.alpha = 1.0
                self?.whereToView.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        } else if lastContentOffset < scrollView.contentOffset.y {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.filterView.alpha = 0
                self?.filterView.transform = CGAffineTransform(translationX: 0, y: -100)
                self?.whereToView.alpha = 0
                self?.whereToView.transform = CGAffineTransform(translationX: 0, y: -100)
            }, completion: nil)
        }
    }
    
    func setupUI() {
        tabBarController?.tabBar.tintColor = UIColor(named: "myColorBlue")
        navigationItem.backButtonTitle = "Back"
        navigationItem.backBarButtonItem?.tintColor = .black
        
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 58, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: (view.frame.width-30)/2, height: ((view.frame.width-30)/2) * 1.7)

        productListCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        productListCollectionView.backgroundColor = .systemGray5
        productListCollectionView.showsVerticalScrollIndicator = false
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: "ProductListCollectionViewCell")
        
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        self.view.addSubview(productListCollectionView)
        self.view.addSubview(filterView)
        self.view.addSubview(whereToView)
        whereToView.addSubview(whereToViewImageView)
        whereToView.addSubview(whereToViewLabel)
        filterView.addSubview(filterViewLabel)
        filterView.addSubview(filterViewImageView)
        filterView.addSubview(sortViewImageView)
        filterView.addSubview(sortViewLabel)

        whereToViewImageView.snp.makeConstraints { make in
            make.leading.equalTo(whereToView.snp.leading).offset(10)
            make.centerY.equalTo(whereToView.snp.centerY)
        }
        
        whereToViewLabel.snp.makeConstraints { make in
            make.leading.equalTo(whereToViewImageView.snp.trailing).offset(8)
            make.centerY.equalTo(whereToView.snp.centerY)
        }
        
        filterViewImageView.snp.makeConstraints { make in
            make.leading.equalTo(filterView.snp.leading).offset(10)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        filterViewLabel.snp.makeConstraints { make in
            make.leading.equalTo(filterViewImageView.snp.trailing).offset(4)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        sortViewImageView.snp.makeConstraints { make in
            make.leading.equalTo(filterView.snp.leading).offset(90)
            make.centerY.equalTo(filterView.snp.centerY)
        }

        sortViewLabel.snp.makeConstraints { make in
            make.leading.equalTo(sortViewImageView.snp.trailing).offset(4)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        productListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(1)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        whereToView.snp.makeConstraints { make in
            make.width.equalTo(((view.frame.width-30) * 0.6) - 12)
            make.height.equalTo(40)

            make.leading.equalToSuperview().offset(10)
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }

        filterView.snp.makeConstraints { make in
            make.width.equalTo(((view.frame.width-30) * 0.4) + 12)
            make.height.equalTo(40)

            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(whereToView.snp.trailing).offset(10)

            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
    }
    
    func loadJsonData() {
        let url = URL(string: "https://api.ciceksepeti.com/v2/listing/ch/products?page=1&url=via-bonte")
        AF.request(url!, method: .get).response { response in
            if let data = response.data {
                do{
                    let generalResponse = try JSONDecoder().decode(GeneralResponse.self, from: data)
                    
                    print((generalResponse.result?.productCount)! as Int)
                    
                    if let gelenUrunListesi = generalResponse.result?.products {
                        self.urunListesi = gelenUrunListesi
                    }
                    DispatchQueue.main.async {
                        self.productListCollectionView.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        if segue.identifier == "ProductDetail" {
            if let nextViewController = segue.destination as? ProductDetailViewController {
                nextViewController.products = urunListesi[indeks!]
            }
        }
    }
}

extension ProductListViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urunListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tLString = " TL"
        let product = urunListesi[indexPath.row]
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as! ProductListCollectionViewCell
        
        cell.urunAdiLabel.text = product.name
        cell.urunFiyatiLabel.text = String(describing: product.price?.total ?? 0.0) + tLString
        
        if let url = URL(string: "\(product.image!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                }
            }
        }
        
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ProductDetail", sender: indexPath.row)
    }

}
