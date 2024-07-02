//
//  FavoritsVC.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import UIKit

class FavoritsVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    var favoritsArray : [DataModel] = []{
        didSet{
            tableView.reloadData()
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritsArray = FavoritesManagerDB.shared.getFavorites()
        
    }
    //Methods
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemsListTableViewCell.nib, forCellReuseIdentifier: ItemsListTableViewCell.cellID)
        tableView.separatorColor = .clear
        
    }
    
    
}//end FavoritsVC

extension FavoritsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoritsArray.count == 0{
            tableView.setNoRecordsMessage("No Favorits yet")
        }else{
            tableView.removeNoRecordsMessage()
        }
        return favoritsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemsListTableViewCell.cellID) as? ItemsListTableViewCell else{return UITableViewCell()}
        cell.doesContainRemFav = true
        cell.itemData = favoritsArray[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .systemBackground
            
            let headerLabel = UILabel()
            headerLabel.text = "You have \(favoritsArray.count) items in favorits"
            headerLabel.textAlignment = .center
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            headerView.addSubview(headerLabel)
            
            // Center the label within the header view
            NSLayoutConstraint.activate([
                headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                headerLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor),
                headerLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor)
            ])
            
            return headerView
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            // Return the height for the header view
            return 50
        }
    
}//end FavoritsVC

extension FavoritsVC : AddRemoveFromFavDelegate{
    func addRemoveItemFromFav(_ item: DataModel) {
        FavoritesManagerDB.shared.removeFromFavorites(item: item)
        favoritsArray = FavoritesManagerDB.shared.getFavorites()
        tableView.reloadData()
    }
    
    
}
