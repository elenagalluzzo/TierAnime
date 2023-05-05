//
//  SearchViewController.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-02.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func addAnime(animeData: Data)
}

class SearchViewController: UIViewController {
    

    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var animeModelArray = [Data]()
    weak var delegate: SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animeModelArray.removeAll()
        
    }

    func callAnimeApi(searchWord: String) {
        AnimeApi.sharedInstance.callAnimeApi(title: searchWord) { [weak self] error, animeModel  in
            if let error = error {
                print(error)
                return
            }
            if let data = animeModel?.data {
                self?.animeModelArray = data
                DispatchQueue.main.async {
                    self?.resultsTableView.reloadData()
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultsTableViewCell else { return UITableViewCell() }
        let currentRowData = animeModelArray[indexPath.row]
        cell.updateCell(model: currentRowData)
        cell.delegate = self
        return cell
    }    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         if let searchWord = searchBar.text {
            callAnimeApi(searchWord: searchWord)
        }
    }
    
}

extension SearchViewController: ResultsCellDelegate {
    func addAnime(animeData: Data) {
        //save data in base
        let alert = UIAlertController(title: "Add to your Anime Tier List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Anime", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
            self.delegate?.addAnime(animeData: animeData)
        }
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
}
