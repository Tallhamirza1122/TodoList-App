//
//  TableViewCell.swift
//  CoreDatas
//
//  Created by Talha's Macbook on 17/09/2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var showData: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
