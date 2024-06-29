//
//  ItemsListTableViewCell.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 29/06/2024.
//

import UIKit
import SDWebImage

class ItemsListTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var itemTitleLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    @IBOutlet weak var itemImgView: UIImageView!
    

    //MARK: - Properties & Varialbles
    static let cellID = "ItemsListTableViewCell"
    static let nib = UINib(nibName: "ItemsListTableViewCell", bundle: nil)
    var itemData : DataModel?{
        didSet{
            loadCell()
        }
    }
    //MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImgView.circle()
    }
    
    //MARK: - Methods
    private func loadCell(){
        guard let itemData = itemData else{return}
        print("itemData = \(itemData)")
        itemTitleLbl.text = itemData.gif.title
        itemDescLbl.text = itemData.gif.alt_text
        
        
        if let url = URL(string: itemData.gif.images.original.url){
            itemImgView.load(url: url)
        }
        
    }
}
