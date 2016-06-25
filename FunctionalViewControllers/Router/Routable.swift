//
//  Routable.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 24.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

//struct AnyRoutable<OutputType> {
//
//}
//
//public protocol Routable {
//
//    associatedtype OutputType: Hashable
//
//    var routes: [OutputType: (OutputType) -> Routable] { get set }
//
//}

/*
public extension Routable {

    public func push(route: String -> Routable, when: String) -> Self {
        routes[when] = route
        return self
    }

    public func finish(key: String, output: String) -> Bool {
        if let route = routes[key] {
            route(output)
            return true
        } else {
            return false
        }
    }

}
*/
