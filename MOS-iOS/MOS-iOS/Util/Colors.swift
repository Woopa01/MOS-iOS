//
//  Colors.swift
//  MOS-iOS
//
//  Created by 조우진 on 31/03/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import UIKit

enum Color {
    case BLUE
    
    func getColor() -> UIColor {
        switch self {
        case .BLUE:
            return UIColor(red: 62/255, green: 87/255, blue: 151/255, alpha: 1)
       
        }
    }
}
