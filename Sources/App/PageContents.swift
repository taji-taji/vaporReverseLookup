//
//  PageContents.swift
//  VaporReverseLookup
//
//  Created by tajika on 2017/06/03.
//
//
import Node
import Foundation

struct PageContents: NodeInitializable {
    
    let title: String
    let contentsBody: String
    let categories: Node
    let currentCategoryName: String
    let currentContentName: String
    
    init(node: Node) throws {
        title = try node.get("title")
        contentsBody = try node.get("contentsBody")
        currentCategoryName = try node.get("currentCategoryName")
        currentContentName = try node.get("currentContentName")
        categories = try PageContents.getSideMenu(with: currentCategoryName, currentContent: currentContentName)
    }
    
}

extension PageContents: NodeRepresentable {
    
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("title", title)
        try node.set("contentsBody", contentsBody)
        try node.set("categories", categories)
        try node.set("currentCategoryName", currentCategoryName)
        try node.set("currentContentName", currentContentName)
        if let isHome = context?.isHomeContext, isHome {
            try node.set("isHome", true)
        }
        return node
    }
    
}

extension PageContents {
    
    /**
     ディレクトリ構造からサイドメニューのコンテンツを取得する
     */
    static func getSideMenu(with currentCategory: String = "", currentContent: String = "") throws -> Node {
        let categoryPath = "Resources/Views/Markdown/Categories"
        let categories = try FileManager.default.contentsOfDirectory(atPath: categoryPath)
        let result: [[String: Node]] = try categories.flatMap({ (category) -> [String: Node]? in
            guard let contents = try? FileManager.default
                .contentsOfDirectory(atPath: "\(categoryPath)/\(category)")
                .flatMap({ (markdownFile) -> String? in
                    return markdownFile
                        .components(separatedBy: ".")
                        .dropLast()
                        .joined(separator: ".")
                })
                else {
                    return nil
            }
            let sub = try contents.map({ (content) -> [String: Node] in
                return [
                    "name": content.makeNode(in: nil),
                    "isCurrentContent": (content == currentContent).makeNode(in: nil),
                    ]
            }).makeNode(in: nil)
            let id = category.substring(with: category.index(category.startIndex, offsetBy: 0)..<category.index(category.startIndex, offsetBy: 2))
            return [
                "isCurrentCategory": (category == currentCategory).makeNode(in: nil),
                "name": category.makeNode(in: nil),
                "id": id.makeNode(in: nil),
                "sub": sub,
            ]
        })
        return try result.makeNode(in: nil)
    }
    
}
