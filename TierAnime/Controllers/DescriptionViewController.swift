//
//  DescriptionViewController.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-02.
//

import UIKit

protocol AnimeInfoDelegate: AnyObject {
    func addAnime(animeData: Data)
}

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    weak var delegate: AnimeInfoDelegate?
    var animeData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let animeData = animeData {
            loadAnimeInfo(model: animeData)
        }
    }
    func loadAnimeInfo(model: Data) {
        animeData = model
        titleLabel.text = model.title
        descriptionLabel.text = model.synopsis
        genreLabel.text = "Action"
        if let genres = model.genres, genres.count > 0 {
            genreLabel.text = "Genre: \(genres[0])"
        }
        episodesLabel.text = "Episodes: \(model.episodes)"
        animeImage?.imageFromURL(urlString: model.image, PlaceHolderImage: UIImage.init(named: "placeholderImage")!)
    }
    
    @IBAction func addAnime(_ sender: Any) {
        if let animeData = animeData {
            delegate?.addAnime(animeData: animeData)
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
}
