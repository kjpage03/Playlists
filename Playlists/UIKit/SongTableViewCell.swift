//
//  SongTableViewCell.swift
//  PlaylistsUIKit
//
//  Created by Kaleb Page on 12/17/20.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    
    var songName = UILabel()
    var songImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        songName = UILabel(frame: CGRect(x: 83, y: 26, width: 45, height: 21))
        songImage = UIImageView(frame: CGRect(x: 20, y: 9, width: 55, height: 55))
        self.addSubview(songName)
        self.addSubview(songImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name: String, image: UIImage) {
        songName.text = name
        songImage.image = image
    }

}
