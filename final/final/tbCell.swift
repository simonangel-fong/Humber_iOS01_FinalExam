//
//  tbCell.swift
//  final
//
//  Created by Simon Fong on 15/12/2023.
//

import Foundation
import UIKit


class tbCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var character: UILabel!
    @IBOutlet weak var actor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
