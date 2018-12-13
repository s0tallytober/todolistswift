//
//  ToDoListTableViewCell.swift
//  TodolistAPP
//
//  Created by Venkatesh K on Saka 1940-09-14.
//  Copyright © 1940 Saka Venkatesh K. All rights reserved.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTask: UILabel!
    @IBOutlet weak var switchStatus: UISwitch!
    
    @IBOutlet weak var btnEdit: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
