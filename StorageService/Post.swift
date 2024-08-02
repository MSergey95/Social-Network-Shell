public struct Post {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    public var title: String
    public var content: String

    public init(author: String, description: String, image: String, likes: Int, views: Int, title: String, content: String) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
        self.title = title
        self.content = content
    }
}
