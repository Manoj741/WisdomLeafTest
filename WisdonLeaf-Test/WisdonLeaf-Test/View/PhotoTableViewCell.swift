//
//  PhotoTableViewCell.swift
//  WisdonLeaf-Test
//
//  Created by manoj kumar on 12/08/20.
//  Copyright © 2020 Manoj Kumar M. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: ImageLoader!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with data: Photo) {
        
//        photoImageView.image
        titleLabel.text = data.author
        descriptionLabel.text = data.url
        
        if let imageUrl = URL(string: data.download_url) {
            photoImageView.loadImage(with: imageUrl)
        }

    }

}
