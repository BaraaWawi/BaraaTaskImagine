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
   
    //MARK: - Setup UI
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemsListTableViewCell.nib, forCellReuseIdentifier: ItemsListTableViewCell.cellID)
        tableView.separatorColor = .clear
        
    }
    //MARK: - Methods
    private func updateHomeItemsList(){
        NotificationCenter.default.post(name: .shouldUpdateItems, object: nil)
        print("post added in HomeViewController")

    }
    
}//end FavoritsVC

//MARK: - UITableViewDelegate & Datasource

extension FavoritsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoritsArray.count == 0{
            tableView.setNoNoDataMessage("No Favorits yet")
        }else{
            tableView.removeNoNoDataMessage()
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
            
            NSLayoutConstraint.activate([
                headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                headerLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor),
                headerLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor)
            ])
            
            return headerView
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 50
        }
    
}//end UITableViewDelegate & Datasource

//MARK: - AddRemoveFromFavDelegate
extension FavoritsVC : AddRemoveFromFavDelegate{
    func addRemoveItemFromFav(_ item: DataModel) {
        FavoritesManagerDB.shared.removeFromFavorites(item: item)
        favoritsArray = FavoritesManagerDB.shared.getFavorites()
        tableView.reloadData()
        updateHomeItemsList()
    }
    
    
}
