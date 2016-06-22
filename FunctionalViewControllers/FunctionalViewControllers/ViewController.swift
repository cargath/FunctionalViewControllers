//
//  ViewController.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 20.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit



class RoutableViewController<R: Hashable>: UIViewController {

    var routes: [R: R -> Void] = [:]

    final func bind(r: R -> Void) -> Self {

        return self
    }

}

enum ProductResult {
    case iOS
    case macOS
    case watchOS
    case tvOS
}

class ProductViewController: RoutableViewController<ProductResult> {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

enum PhoneResult {
    case iPhoneSE
    case iPhone6s
    case iPhone6sPlus
}

class PhoneViewController: RoutableViewController<PhoneResult> {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

enum MacResult {
    case MacBook
    case MacBookAir
    case MacBookPro
    case MacMini
    case MacPro
    case iMac
}

class MacViewController: RoutableViewController<MacResult> {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

enum WatchResult {
    case AppleWatchSport
    case AppleWatch
    case AppleWatchEdition
}

class WatchViewController: RoutableViewController<WatchResult> {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

enum TVResult {
    case AppleTV
}

class TVViewController: RoutableViewController<TVResult> {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}
