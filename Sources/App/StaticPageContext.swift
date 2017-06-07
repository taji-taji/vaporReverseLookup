//
//  StaticPageContext.swift
//  VaporReverseLookup
//
//  Created by tajika on 2017/06/04.
//
//

import Foundation
import Node

enum StaticPage: CustomStringConvertible {
    case home
    case author

    var description: String {
        switch self {
        case .home:
            return "home"
        case .author:
            return "author"
        }
    }
}

final class StaticPageContext: Context {
    var page: StaticPage

    init(page: StaticPage) {
        self.page = page
    }
}

extension Context {
    var isStaticPageContext: String? {
        guard let staticPageContextSelf = self as? StaticPageContext else {
            return nil
        }
        return staticPageContextSelf.page.description
    }
}
