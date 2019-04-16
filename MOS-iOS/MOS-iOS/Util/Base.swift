//
//  Base.swift
//  MOS-iOS
//
//  Created by 조우진 on 16/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit

extension ASViewController {
    open override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = Color.RED.getColor()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}
