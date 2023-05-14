//
//  DescriptionViewController.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-02.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var animeData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
