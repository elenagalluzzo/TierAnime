//
//  Utilities.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-04.
//

import Foundation
import UIKit

extension UIImageView {

 public func imageFromURL(urlString: String, PlaceHolderImage:UIImage) {

        if self.image == nil{
              self.image = PlaceHolderImage
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }}
