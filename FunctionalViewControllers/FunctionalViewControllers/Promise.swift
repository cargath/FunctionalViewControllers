//
//  Promise.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 20.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

public struct Promise<T, E> {

    public typealias ResultType = Result<T, E>
    public typealias Completion = ResultType -> Void
    public typealias AsyncOperation = Completion -> Void

    private let operation: AsyncOperation

    public init(result: ResultType) {
        self.init(operation: { completion in
            completion(result)
        })
    }

    public init(value: T) {
        self.init(result: .Value(value))
    }

    public init(error: E) {
        self.init(result: .Error(error))
    }

    public init(operation: AsyncOperation) {
        self.operation = operation
    }

    public func onCompletion(completion: Completion) {
        self.operation() { result in
            completion(result)
        }
    }

    public func onCompletion(success success: T -> Void, error: E -> Void) {
        self.onCompletion { result in
            result
                .onValue(success)
                .onError(error)
        }
    }

}

// MARK: Chaining

extension Promise {

    public func then<U>(f: T -> Promise<U, E>) -> Promise<U, E> {
        return Promise<U, E>(operation: { completion in
            self.onCompletion { firstFutureResult in
                switch firstFutureResult {
                case .Value(let valueBox):
                    f(valueBox).onCompletion(completion)
                case .Error(let errorBox):
                    completion(Result.Error(errorBox))
                }
            }
        })
    }

}

// MARK: Lifting (using non promise methods)

extension Promise {

    public func lift<U>(f: T -> U) -> Promise<U, E> {
        return Promise<U, E>(operation: { completion in
            self.onCompletion { result in
                switch result {
                case .Value(let valueBox):
                    completion(Result.Value(f(valueBox)))
                case .Error(let errorBox):
                    completion(Result.Error(errorBox))
                }
            }
        })
    }

    public func lift<U>(f: T -> Result<U, E>) -> Promise<U, E> {
        return Promise<U, E>(operation: { completion in
            self.onCompletion { result in
                switch result {
                case .Value(let valueBox):
                    completion(f(valueBox))
                case .Error(let errorBox):
                    completion(Result.Error(errorBox))
                }
            }
        })
    }

}
