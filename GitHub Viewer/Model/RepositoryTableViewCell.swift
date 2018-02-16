//
//  RepositoryTableViewCell.swift
//  GitHub Viewer
//
//  Created by João Leite on 15/02/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRepositoryName: UILabel!
    @IBOutlet weak var lblRepositoryLanguage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
