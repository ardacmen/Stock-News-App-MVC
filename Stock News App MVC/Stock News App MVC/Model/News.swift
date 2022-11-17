
import Foundation

struct Result: Codable {
    let articles: [News]
}

struct News: Codable{
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}

struct Source: Codable {
    let id: String?
    let name: String
}
