//
//  SearchTableViewCell.swift
//  Voice_copy
//
//  Created by putao on 2022/6/2.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
