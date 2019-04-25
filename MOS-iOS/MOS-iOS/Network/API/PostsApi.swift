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
        case .newposts: return "/newposts"
        case .getpostlist: return "/getpostlist"
        case .newcomment: return "/newcomment"
        case .getpostdetail: return "/getpostdetail"
    }
}
}
