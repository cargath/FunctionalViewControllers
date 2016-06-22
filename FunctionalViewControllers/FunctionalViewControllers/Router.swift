//
//  Router.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 23.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

struct Router<A, B> {
    let create: (A, (B, UINavigationController) -> Void) -> UINavigationController
}

extension Router {

    init(rootViewController: Screen<A, B>) {
        create = { initial, callback in
            let navController = UINavigationController()
            let rootController = rootViewController.create(initial, { callback($0, navController) })
            navController.viewControllers = [rootController]
            return navController
        }
    }

    func push<C>(other: Screen<B, C>) -> Router<A, C> {
        return Router<A, C> { x, callback in
            let nc = self.create(x, { b, nc in
                let rvc = other.create(b, { c in
                    callback(c, nc)
                })
                nc.pushViewController(rvc, animated: true)
            })
            return nc
        }
    }

    func modal<C>(other: Screen<B, C>) -> Router<A, C> {
        return Router<A, C> { x, callback in
            let nc = self.create(x, { b, nc in
                let rvc = other.create(b, { c in
                    callback(c, nc)
                })
                nc.presentViewController(UINavigationController(rootViewController: rvc), animated: true, completion: nil)//pushViewController(rvc, animated: true)
            })
            return nc
        }
    }

    func map<C>(f: B -> C) -> Router<A, C> {
        return Router<A, C> { x, callback in
            return self.create(x) { (y, nc) in
                callback(f(y), nc)
            }
        }
    }

    func run(initialValue: A, finish: B -> Void = { print($0) }) -> UINavigationController {
        return create(initialValue) { b, _ in
            finish(b)
        }
    }
    
}
