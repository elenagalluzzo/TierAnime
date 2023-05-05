//
//  TierTableViewCell.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-03.
//

import UIKit
import AARatingBar
import FirebaseFirestore

class TierTableViewCell: UITableViewCell {
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starRatingBar: AARatingBar!
    
    let database = Firestore.firestore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(model: Data) {
        titleLabel.text = model.title
        animeImage?.imageFromURL(urlString: model.image, PlaceHolderImage: UIImage.init(named: "placeholderImage")!)

        starRatingBar.ratingDidChange = { ratingValue in
            self.database.collection("Data").whereField("Title", isEqualTo: model.title).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    let document = querySnapshot!.documents.first
                    document?.reference.updateData([
                        "Rating": ratingValue
                    ])
                }
            }
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
