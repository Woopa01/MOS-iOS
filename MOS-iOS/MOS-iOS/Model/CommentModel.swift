//
//  CommentModel.swift
//  MOS-iOS
//
//  Created by 조우진 on 17/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
struct CommentModel : Codable {
    let date: String
    let commentId: String
    let commentAuthor: String
    let content: String
    
    enum CodingKeys: String, CodingKey{
        case date
        case commentId = "_id"
        case commentAuthor = "author"
        case content
    }
}
