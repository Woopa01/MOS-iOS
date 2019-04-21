//
//  ViewModelType .swift
//  MOS-iOS
//
//  Created by 조우진 on 17/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
