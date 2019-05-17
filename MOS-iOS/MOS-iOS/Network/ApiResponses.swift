//
//  ApiResponses.swift
//  MOS-iOS
//
//  Created by 조우진 on 17/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation

struct PostsListResponse: Codable {
    let postlist: [PostModel]
    
    enum CodingKeys: String, CodingKey{
        case postlist = "posts"
    }
}
