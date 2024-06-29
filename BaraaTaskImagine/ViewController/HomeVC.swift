//
//  HomeVC.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties & Varialbles
    private var itemsViewModel = ItemsViewModel()
    private var items : ItemsModel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getData()
        
        
    }
    //MARK: - Methods
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemsListTableViewCell.nib, forCellReuseIdentifier: ItemsListTableViewCell.cellID)
        tableView.separatorColor = .clear
    }
    private func getData(){
        itemsViewModel.getItemsList()//call api
        
        itemsViewModel.itemsLoaded = { [weak self] in
            guard let self = self else{return}
            items = itemsViewModel.items
            
            DispatchQueue.main.async{
                self.items = self.itemsViewModel.items
                self.tableView.reloadData()
            }
        }
    }
    
}//end HomeVC

//MARK: - UITableView Delegate & Datasource
extension HomeVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemsListTableViewCell.cellID, for: indexPath) as? ItemsListTableViewCell else{return UITableViewCell()}
        
        cell.itemData = items?.data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
