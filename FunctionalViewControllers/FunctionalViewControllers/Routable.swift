//
//  Routable.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 24.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

public struct AnyRoutable {

}

public protocol Routable {

    //associatedtype InputType
    associatedtype OutputType
    associatedtype KeyType: Hashable

    var routes: [KeyType: OutputType -> AnyRoutable] { get set }

}

public extension Routable {

    public func push(f: OutputType -> AnyRoutable, to: KeyType) {
        //
    }

    public func commit() {
        //
    }

}
