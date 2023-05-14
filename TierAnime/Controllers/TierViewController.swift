//
//  ViewController.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-01.
//

import UIKit
import FirebaseFirestore

class TierViewController: UIViewController {

    @IBOutlet weak var tierTableView: UITableView!
    
    let database = Firestore.firestore()
   
    var tierArray = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tierTableView.dataSource = self
        tierTableView.delegate = self
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchController" {
            if let controller = segue.destination as? SearchViewController {
                controller.delegate = self
            }
        }
    }
    
    func loadData() {
        database.collection("Data").order(by: "Rating").addSnapshotListener() { (querySnapshot, error) in
                    self.tierArray = []
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let loadedTitle = data["Title"] as? String, let loadedImage = data["Image"] as? String, let loadedRating = data["Rating"] as? Int, let loadedGenre = data["Genre"] as? String, let loadedSynopsis = data["Synopsis"] as? String, let loadedEpisodes = data ["Episodes"] as? Int {
                        let loadedData = Data(title: loadedTitle, genres: [loadedGenre], episodes: loadedEpisodes, image: loadedImage, synopsis: loadedSynopsis, rating: loadedRating)
                        self.tierArray.append(loadedData)
                        DispatchQueue.main.async {
                            self.tierTableView.reloadData()
                        }
                        
                    }
                }
            }
        }
    }
}


extension TierViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tierArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "animeTierCell", for: indexPath) as? TierTableViewCell else { return UITableViewCell ()}
        let currentRowData = tierArray[indexPath.row]
        cell.updateCell(model: currentRowData)
        return cell
    }
        
}


extension TierViewController: SearchViewControllerDelegate {
    func addAnime(animeData: Data) {
        tierArray.append(animeData)
        
       database.collection("Data").addDocument(data: [
            "Title": animeData.title,
            "Genre": animeData.genres?[0] ?? "Action",
            "Synopsis": animeData.synopsis,
            "Episodes": animeData.episodes,
            "Image": animeData.image,
            "Rating": 0.0
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Successfully saved")
            }
        }
        tierTableView.reloadData()
    }
}
