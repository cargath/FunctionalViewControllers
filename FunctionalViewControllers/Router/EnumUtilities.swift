//
//  EnumUtilities.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 24.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

func iterate<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafePointer(&i) {
            UnsafePointer<T>($0).pointee
        }
        if next.hashValue == i {
            i += 1
            return next
        } else {
            return nil
        }
    }
}

func count<T: Hashable>(_ t: T.Type) -> Int {
    var count = 0
    for _ in iterate(t) {
        count += 1
    }
    return count
}
