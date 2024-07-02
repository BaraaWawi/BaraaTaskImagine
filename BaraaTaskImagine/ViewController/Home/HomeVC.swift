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
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties & Varialbles
    private var itemsViewModel = ItemsViewModel()
    private var items : ItemsModel?
    private var isSearching = false
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        getData()
        
    }
    
    //MARK: - Setup UI
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemsListTableViewCell.nib, forCellReuseIdentifier: ItemsListTableViewCell.cellID)
        tableView.separatorColor = .clear
    }
    private func setupSearchBar(){
        searchBar.delegate = self
        searchBar.placeholder = "Search"
    }
    
    //MARK: - Api Calling
    private func getData(){
        itemsViewModel.getItemsList()//call api
        
        //load api resp
        itemsViewModel.itemsLoaded = { [weak self] in
            guard let self = self else{return}
            items = itemsViewModel.items
            
            DispatchQueue.main.async{
                
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
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemDetailsVC") as? ItemDetailsVC else{return}
        vc.itemData = items?.data[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offsetY = scrollView.contentOffset.y
         let contentHeight = scrollView.contentSize.height
         let frameHeight = scrollView.frame.size.height
         
         if offsetY > contentHeight - frameHeight - 100 {
             getData()
         }
     }
}

//MARK: - UISearchbar Delegate
extension HomeVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isSearching = false
            itemsViewModel.resetOffset()

            getData()
        }else{
          isSearching = true
            itemsViewModel.searchItems(query: searchText)
        }
    }
}
