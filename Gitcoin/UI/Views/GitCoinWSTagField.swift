//
//  GitCoinWSTagField.swift
//  Gitcoin
//
//  Created by Craig Heneveld on 11/24/17.
//  Copyright © 2017 Gitcoin. All rights reserved.
//

import UIKit
import WSTagsField

class GitCoinWSTagField: WSTagsField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }

    fileprivate func internalInit(){
        padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        spaceBetweenTags = 10.0
        font = UIFont(name: "Futura", size: 14.0)
        tintColor = UIColor.gitCoin.darkCosmicTeal
        textColor = .black
        fieldTextColor = .black
        selectedColor = UIColor.gitCoin.polarisBlue
        selectedTextColor = UIColor.gitCoin.celestialWhite
    }
}
