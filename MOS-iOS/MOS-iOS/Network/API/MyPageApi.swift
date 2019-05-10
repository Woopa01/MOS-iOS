//
//  MyPageApi.swift
//  MOS-iOS
//
//  Created by 조우진 on 25/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
enum MyPageApi : API{
    
    case signup, login, getprofile, getposts

    func getPath() -> String {
        switch self {
        case .signup: return "user/signup"
        case .login: return "user/login"
        case .getprofile: return "user/getprofile"
        case .getposts: return "user/getposts"
        }
    }
}
