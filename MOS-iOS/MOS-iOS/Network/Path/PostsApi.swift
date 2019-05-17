//
//  PostsApi.swift
//  MOS-iOS
//
//  Created by 조우진 on 25/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation

enum PostsApi : API {
    case newposts, getpostlist, newcomment, getpostdetail
    func getPath() -> String {
        switch self {
        case .newposts: return "posts/newposts"
        case .getpostlist: return "posts/getpostslist"
        case .newcomment: return "posts/newcomment"
        case .getpostdetail: return "posts/getpostdetail"
    }
}
}
