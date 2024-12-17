//
//  Post.swift
//  Navigation
//

import Foundation

class Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int

    init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}
