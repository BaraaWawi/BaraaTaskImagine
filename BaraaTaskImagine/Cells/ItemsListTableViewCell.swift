//
//  ItemsListTableViewCell.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 29/06/2024.
//

import UIKit
import SDWebImage

protocol AddRemoveFromFavDelegate {
    func addRemoveItemFromFav(_ item : DataModel)
}

class ItemsListTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var itemTitleLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var addRemoveFavBtn: UIButton!
    
    //MARK: - Properties & Varialbles
    static let cellID = "ItemsListTableViewCell"
    static let nib = UINib(nibName: "ItemsListTableViewCell", bundle: nil)
    
    var delegate : AddRemoveFromFavDelegate?
    var itemData : DataModel?{
        didSet{
            loadCell()
        }
    }
    var doesContainRemFav = false
    var isItemInFav = false
    
    //MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupfavBtn()
       
    }
    //MARK: - setupUI
    private func setupfavBtn(){
        itemImgView.circle()
        addRemoveFavBtn.addTarget(self, action: #selector(removeFavBtnPressed), for: .touchUpInside)
        addRemoveFavBtn.tintColor = .blue
    }
    
    private func customizeFavBtn(){
        if doesContainRemFav{
            
            addRemoveFavBtn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)

        }else if isItemInFav{
            addRemoveFavBtn.setImage(UIImage(named: "addedToFav"), for: .normal)

        }else{
            addRemoveFavBtn.setImage(UIImage(named: "addToFav"), for: .normal)

        }

    }
    //MARK: - Methods
    private func loadCell(){
       customizeFavBtn()
        guard let itemData = itemData else{return}
        print("itemData = \(itemData)")
        itemTitleLbl.text = itemData.title
        itemDescLbl.text = itemData.alt_text
        
        itemImgView.sd_setImage(with: URL(string: itemData.images.original.url), completed: nil)
        // i will use sd web image because it is better with loading urls
//        if let url = URL(string: itemData.images.original.url){
//            itemImgView.load(url: url)
//        }
        
    }
    
    //MARK: - Selectors
    @objc private func removeFavBtnPressed(){
        guard let itemData = itemData else{return}
        delegate?.addRemoveItemFromFav(itemData)
    }
}
