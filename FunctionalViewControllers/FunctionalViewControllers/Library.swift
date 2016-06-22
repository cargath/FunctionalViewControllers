//
//  Library.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 22.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

public class Box<T> {
    public let unbox: T
    public init(_ value: T) { self.unbox = value }
}

struct ViewController<A, B> {
    let create: (A, B -> Void) -> UIViewController
}

extension ViewController {

    func map<C>(f: B -> C) -> ViewController<A, C> {
        return ViewController<A, C> { x, callback in
            return self.create(x) { y in
                callback(f(y))
            }
        }
    }

    func run(initialValue: A, finish: B -> ()) -> UIViewController {
        return create(initialValue, finish)
    }

}

struct NavigationController<A, B> {
    let create: (A, (B, UINavigationController) -> ()) -> UINavigationController
}

extension NavigationController {

    init(rootViewController: ViewController<A, B>) {
        create = { initial, callback in
            let navController = UINavigationController()
            let rootController = rootViewController.create(initial, { callback($0, navController) } )
            navController.viewControllers = [rootController]
            return navController
        }
    }

    func bind<C>(other: ViewController<B, C>) -> NavigationController<A, C> {
        return NavigationController<A, C> { x, callback in
            let nc = self.create(x, { b, nc in
                let rvc = other.create(b, { c in
                    callback(c, nc)
                })
                nc.pushViewController(rvc, animated: true)
            })
            return nc
        }
    }

    func map<C>(f: B -> C) -> NavigationController<A, C> {
        return NavigationController<A, C> { x, callback in
            return self.create(x) { (y, nc) in
                callback(f(y), nc)
            }
        }
    }

    func run(initialValue: A, finish: B -> ()) -> UINavigationController {
        return create(initialValue) { b, _ in
            finish(b)
        }
    }
    
}
