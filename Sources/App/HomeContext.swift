//
//  HomeContext.swift
//  VaporReverseLookup
//
//  Created by tajika on 2017/06/04.
//
//

import Foundation
import Node

final class HomeContext: Context {
}

let context = HomeContext()

extension Context {
    var isHomeContext: Bool {
        return self is HomeContext
    }
}
