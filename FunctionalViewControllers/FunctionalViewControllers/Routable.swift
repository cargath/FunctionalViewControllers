//
//  Routable.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 22.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

public protocol Routable {

    associatedtype R: Hashable

    var routes: [R: R -> Void] { get set }
    
}
