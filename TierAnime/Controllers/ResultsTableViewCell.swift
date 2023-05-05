//
//  ResultsTableViewCell.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-02.
//

import UIKit

protocol ResultsCellDelegate: AnyObject {
    func addAnime(animeData: Data)
    
}
class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    weak var delegate: ResultsCellDelegate?
    var animeData: Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(model: Data) {
        animeData = model
        titleLabel.text = model.title
        descriptionLabel.text = model.synopsis
        animeImage?.imageFromURL(urlString: model.image, PlaceHolderImage: UIImage.init(named: "placeholderImage")!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func addAnime(_ sender: Any) {
        if let animeData = animeData {
            delegate?.addAnime(animeData: animeData)
        }
    }
}




