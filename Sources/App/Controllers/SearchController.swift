import Vapor
import HTTP
import Node

final class SearchController: ResourceRepresentable {

    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }

    /// GET /search
    func index(_ req: Request) throws -> ResponseRepresentable {
        let queries = req.query?.object
        guard let searchQuery = queries?["q"]?.string?.lowercased() else {
            return JSON()
        }
        let limit: Int = queries?["limit"]?.int ?? 100
        print(searchQuery)
        var resultPaths: [[String : Any]] = []

        let contents = try PageContents.getSideMenu()
        contents.array?.forEach({ (category) in
            guard let id = category["id"]?.string, let sub = category["sub"]?.array, let categoryName = category["name"]?.string else {
                return
            }
            sub.forEach({ (content) in
                guard resultPaths.count < limit else {
                    return
                }
                guard
                    let fileName = content.object?["name"]?.string,
                    let markdown = try? String(contentsOfFile: "Resources/Views/Markdown/Categories/\(categoryName)/\(fileName).md") else {
                        return
                }
                if markdown.lowercased().contains(searchQuery) {
                    let dict: [String: String] = [
                        "path": "/\(id)/\(fileName)?q=\(searchQuery)",
                        "name": fileName,
                        "query": searchQuery
                    ]
                    resultPaths.append(dict)
                }
            })
        })
        return try JSON(node: resultPaths)
    }

    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this 
    /// implementation
    func makeResource() -> Resource<String> {
        return Resource(
            index: index
        )
    }
}
