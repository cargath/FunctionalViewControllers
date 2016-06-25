//
//  RoutableViewController.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 24.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

public struct Route<OutputType: Hashable> {
    
}

public class RoutableViewController<OutputType: Hashable>: UITableViewController {

    // Seems like the compiler turns this into '[OutputType: (OutputType) -> RoutableViewController<OutputType>]'.
    // Explains why it doesn't complain about 'Self or associated type requirements'.
    // var routes: [OutputType: (OutputType) -> RoutableViewController] = [:]

    var route: ((OutputType) -> UIViewController)?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    public func push(_ route: (OutputType) -> UIViewController) -> Self {
        self.route = route
        return self
    }

    public func finish(_ output: OutputType) -> Bool {
        if let
            route = self.route,
            navigationController = self.navigationController {
            navigationController.pushViewController(route(output), animated: true)
            return true
        } else {
            return false
        }
    }
    
}
