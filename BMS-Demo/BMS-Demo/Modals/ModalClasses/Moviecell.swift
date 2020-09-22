//
//  Moviecell.swift
//  BMS-Demo
//
//  Created by apple on 23/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class Moviecell: UITableViewCell {

    @IBOutlet weak var lblmoviename: UILabel!
    @IBOutlet weak var lbldesc: UILabel!
    @IBOutlet weak var lblreleasedate: UILabel!
    @IBOutlet weak var imgposter: UIImageView!
    @IBOutlet weak var btnbook: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
