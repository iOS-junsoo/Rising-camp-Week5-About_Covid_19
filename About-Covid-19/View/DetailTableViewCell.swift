//
//  DetailTableViewCell.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/14.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    //@IBOutlet weak var location: UILabel!
    @IBOutlet weak var number: UILabel!
    
    var restaurantToDisplay: Row?
    
    func displayRastaurant(row:Row){
        restaurantToDisplay = row
            
        name.text = restaurantToDisplay!.RELAX_RSTRNT_NM
        name.sizeToFit()
//        location.text = "\(restaurantToDisplay!.RELAX_ADD1) \(restaurantToDisplay!.RELAX_ADD2)"
        //location.sizeToFit()
        number.text = restaurantToDisplay!.RELAX_RSTRNT_TEL
        number.sizeToFit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
