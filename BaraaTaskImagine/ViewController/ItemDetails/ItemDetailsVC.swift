//
//  ItemDetailsVC.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import UIKit

class ItemDetailsVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var slugLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var addToFavBtn: UIButton!
    
    //MARK: - Variables
    var itemData : DataModel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addToFavBtn.addTarget(self, action: #selector(addToFavBtnPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoritesButton()

    }
    //MARK: - ConfigureUI
    private func configureUI(){
        navigationItem.title = "Item Details"
        loadScreenData()
        
        
        
    }
    //MARK: - Methods
    private func loadScreenData(){
        guard let itemData = itemData else{return}
        titleLbl.text = itemData.title
        typeLbl.text = itemData.type
        slugLbl.text = itemData.slug
        descriptionLbl.text = itemData.alt_text
        imgView.sd_setImage(with: URL(string: itemData.images.original.url))
        
        
    }
    
    @objc private func addToFavBtnPressed(){
        guard let itemData = itemData else{return}
        if FavoritesManagerDB.shared.isFavorite(item: itemData) {
            FavoritesManagerDB.shared.removeFromFavorites(item: itemData)
        } else {
            FavoritesManagerDB.shared.saveToFavorites(item: itemData)
        }
        updateFavoritesButton()
        
        
    }
    
    private func updateFavoritesButton() {
        guard let itemData = itemData else{return}
        let imgName = FavoritesManagerDB.shared.isFavorite(item: itemData) ? "addedToFav" : "addToFav"
        addToFavBtn.setImage(UIImage(named: imgName), for: .normal)
        
    }
    
}

