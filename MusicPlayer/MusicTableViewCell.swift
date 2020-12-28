//
//  MusicTableViewCell.swift
//  MusicPlayer
//
//  Created by Janarthan Subburaj on 28/12/20.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var AlbumImage: UIImageView!
    
    @IBOutlet weak var MusicName: UILabel!
    
    @IBOutlet weak var MusicAlbumName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        AlbumImage.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
