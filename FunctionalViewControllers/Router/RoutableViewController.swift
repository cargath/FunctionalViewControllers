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

    var routes: [OutputType: (OutputType) -> UIViewController] = [:]

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    public func push<NextOutputType: Hashable>(_ key: OutputType, route: (OutputType) -> RoutableViewController<NextOutputType>) -> Self {
        routes[key] = route
        return self
    }

    public func finish(_ key: OutputType, output: OutputType) -> Bool {
        if let
            route = routes[key],
            navigationController = self.navigationController {
            navigationController.pushViewController(route(output), animated: true)
            return true
        } else {
            return false
        }
    }
    
}
