import Vapor
import Foundation
import SwiftMarkdown

final class Routes: RouteCollection {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    func build(_ builder: RouteBuilder) throws {
        
        /// GET /
        builder.get { req in
            let markdown = try String(contentsOfFile: "Resources/Views/Markdown/welcome.md")
            let html = try markdownToHTML(markdown, options: [])
            let contents = try PageContents(node: [
                "title": "逆引き Vapor",
                "contentsBody": html,
                "currentCategoryName": "".makeNode(in: nil),
                "currentContentName": "".makeNode(in: nil),
                ])
                .makeNode(in: StaticPageContext(page: .home))
            return try self.view.make("base", contents, for: req)
        }

        /// GET /author
        builder.get("author") { req in
            let markdown = try String(contentsOfFile: "Resources/Views/Markdown/author.md")
            let html = try markdownToHTML(markdown, options: [])
            let contents = try PageContents(node: [
                "title": "逆引き Vapor | Author",
                "contentsBody": html,
                "currentCategoryName": "".makeNode(in: nil),
                "currentContentName": "".makeNode(in: nil),
                ])
                .makeNode(in: StaticPageContext(page: .author))
            return try self.view.make("base", contents, for: req)
        }

        let contents = try PageContents.getSideMenu()
        contents.array?.forEach({ (category) in
            guard let id = category["id"]?.string, let sub = category["sub"]?.array, let name = category["name"]?.string else {
                return
            }
            // 各カテゴリーのグループを作成
            builder.group(id, handler: { (cat_builder) in
                sub.forEach({ (content) in
                    guard
                        let path = content.object?["name"]?.string,
                        let markdown = try? String(contentsOfFile: "Resources/Views/Markdown/Categories/\(name)/\(path).md"),
                        let html = try? markdownToHTML(markdown, options: []),
                        let c = try? PageContents(node: [
                            "title": "逆引き Vapor | \(name) | \(path)",
                            "contentsBody": html,
                            "currentCategoryName": name,
                            "currentContentName": path,
                            ])
                        else {
                            return
                    }
                    // 各カテゴリー配下のmarkdownのコンテンツをルーティングに追加
                    let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    cat_builder.get(encodedPath) { req in
                        return try self.view.make("base", c, for: req)
                    }
                })
            })
        })
        
    }
}
