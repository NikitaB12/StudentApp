//
//  CustomTableViewCell.swift
//  CollapsibleTableview
//
//  Created by Nikita Vilas Barhate on 01/09/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var lbl : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public var student: Student! {
        didSet {
            self.lbl.text = student.name
        }
    }
}
