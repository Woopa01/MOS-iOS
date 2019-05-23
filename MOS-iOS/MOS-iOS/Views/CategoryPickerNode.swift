//
//  CategoryPickerNode.swift
//  MOS-iOS
//
//  Created by 조우진 on 23/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CategoryPickerNode: ASDisplayNode{
    
    var pickerView: UIPickerView {
        return self.view as! UIPickerView
    }
    
    override init() {
        super.init()
        self.setViewBlock { () -> UIView in
            let picker = UIPickerView(frame: CGRect(x: 17, y: 52, width: 270, height: 100))
            return picker
        }
    }
}
