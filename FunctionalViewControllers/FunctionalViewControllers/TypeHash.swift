//
//  TypeHash.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 22.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

struct TypeHash<R> {
    //
}

extension TypeHash: Equatable {
    func isEqual(to other: TypeHash) -> Bool {
        return hashValue == other.hashValue
    }
}

extension TypeHash: Hashable {
    var hashValue: Int {
        return "\(R.self)".hashValue
    }
}

func == <R>(lhs: TypeHash<R>, rhs: TypeHash<R>) -> Bool {
    return lhs.isEqual(to: rhs)
}
