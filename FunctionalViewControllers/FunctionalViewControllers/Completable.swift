//
//  Completable.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 20.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

public protocol Completable {

    associatedtype R

    var onCompletion: R -> Void { get set }

}
