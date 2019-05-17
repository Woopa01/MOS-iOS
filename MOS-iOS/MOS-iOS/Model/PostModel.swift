//
//  PostModel.swift
//  MOS-iOS
//
//  Created by 조우진 on 17/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
struct PostModel : Codable {
    let date: String
    let commentCount: Int
    let isVoted: Bool
    let voteCount: Int
    let postId: String
    let postTitle: String
    let postContent: String
    let postAuthor: String
    let category: String
    let comment: [CommentModel]
    
    enum CodingKeys: String, CodingKey{
        case date
        case commentCount
        case isVoted
        case voteCount
        case postId = "_id"
        case postTitle = "title"
        case postContent = "content"
        case postAuthor = "author"
        case category
        case comment
    }
}
