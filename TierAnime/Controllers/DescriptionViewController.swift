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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadAnimeInfo(model: Data) {
        titleLabel.text = model.title
        descriptionLabel.text = model.synopsis
        genreLabel.text = "Genre: \(model.genres?[0] ?? "Action")"
        episodesLabel.text = "Episodes: \(model.episodes)"
        animeImage?.imageFromURL(urlString: model.image, PlaceHolderImage: UIImage.init(named: "placeholderImage")!)
    }
    
    @IBAction func addAnime(_ sender: Any) {
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
