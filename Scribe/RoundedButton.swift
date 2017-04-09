//
//  RoundedButton.swift
//  Scribe
//
//  Created by Kalyan Dechiraju on 09/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
