//
//  PostsVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 01/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

class PostsVC : ASViewController<ASDisplayNode> {
    
    init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
