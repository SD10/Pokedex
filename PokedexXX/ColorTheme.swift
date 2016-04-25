//
//  ColorTheme.swift
//  PokedexXX
//
//  Created by Steven on 4/22/16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation
import UIKit

enum ColorTheme {
    case CharamanderRed
    case SquirtleBlue
    case BulbasaurGreen
    case PikachuYellow
    case OnyxGrey
    
    
    var colorTheme: UIColor {
        switch self {
        case .CharamanderRed: return UIColor.charamanderRed()
        case .SquirtleBlue: return UIColor.squirtleBlue()
        case .BulbasaurGreen: return UIColor.bulbasaurGreen()
        case .PikachuYellow: return UIColor.pikachuYellow()
        case .OnyxGrey: return UIColor.onyxGrey()
        }
    }
}