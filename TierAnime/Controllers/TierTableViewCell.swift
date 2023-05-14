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
    var isFromTableViewLoad = true
    let database = Firestore.firestore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(model: Data) {
        titleLabel.text = model.title
        animeImage?.imageFromURL(urlString: model.image, PlaceHolderImage: UIImage.init(named: "placeholderImage")!)
        starRatingBar.value = CGFloat(model.rating ?? 0)
        starRatingBar.ratingDidChange = { ratingValue in
            guard self.isFromTableViewLoad else {
                self.isFromTableViewLoad = false
                return
            }
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
