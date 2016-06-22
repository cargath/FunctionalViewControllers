//
//  Screen.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 23.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

struct Screen<A, B> {
    let create: (A, B -> Void) -> UIViewController
}

extension Screen {

    func map<C>(f: B -> C) -> Screen<A, C> {
        return Screen<A, C> { x, callback in
            return self.create(x) { y in
                callback(f(y))
            }
        }
    }

    func run(initialValue: A, finish: B -> Void = { print($0) }) -> UIViewController {
        return create(initialValue, finish)
    }
    
}
