//
//  AlunoTableViewCell.swift
//  AlunoSwiftAPP
//
//  Created by pos on 07/12/2018.
//  Copyright © 2018 pos. All rights reserved.
//

import UIKit

class AlunoTableViewCell: UITableViewCell {
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblNota: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



