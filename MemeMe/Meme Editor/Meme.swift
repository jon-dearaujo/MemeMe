//
//  Meme.swift
//  MemeMe
//
//  Created by Jonathan De Araújo Silva on 20/08/22.
//

import Foundation
import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    var image: UIImage
    var memedImage: UIImage

    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}
