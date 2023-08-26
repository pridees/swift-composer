//    Copyright (c) <2022> Alexandr Ovcharenko
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Foundation

#if canImport(Combine)
import Combine

public func fireOnce<P, T>(
    _ receiveValue: @escaping (T) -> Void
) -> (P) -> Void where P: Publisher, P.Output == T, P.Failure == Never {
    return { publisher in
        var subsciption: AnyCancellable?
        subsciption = publisher
            .sink(receiveValue: {
                receiveValue($0)
                subsciption?.cancel()
                subsciption = nil
            })
    }
}

public func fireOnce<P, T, E>(
    _ recieveValue: @escaping (T) -> Void,
    _ recieveError: ((P.Failure) -> Void)? = nil
) -> (P) -> Void where P: Publisher, P.Output == T, P.Failure == E {
    return { publisher in
        var subsciption: AnyCancellable?
        subsciption = publisher
            .sink(
                receiveCompletion: { competion in
                    switch(competion) {
                    case let .failure(error):
                        recieveError?(error)
                        fallthrough
                    case .finished:
                        subsciption?.cancel()
                        subsciption = nil
                    }
                },
                receiveValue: {
                    recieveValue($0)
                    subsciption?.cancel()
                    subsciption = nil
                }
            )
    }
}

public func fireAndForget<P, E>(_ publisher: P) -> Void where P: Publisher, P.Failure == E {
    var subsciption: AnyCancellable?
    subsciption = publisher
        .ignoreOutput()
        .sink(
            receiveCompletion: { _ in
                subsciption?.cancel()
                subsciption = nil
            },
            receiveValue: { _ in }
        )
}

public func fireAndForget<P, E>(
    _ completion: @escaping (Subscribers.Completion<P.Failure>) -> Void
) -> (P) -> Void where P: Publisher, P.Failure == E {
    return { publisher in
        var subsciption: AnyCancellable?
        subsciption = publisher
            .ignoreOutput()
            .sink(
                receiveCompletion: {
                    subsciption?.cancel()
                    subsciption = nil
                    completion($0)
                },
                receiveValue: { _ in }
            )
    }
}

public func run<P, T, E>(
    _ recieveValue: @escaping (T) -> Void,
    _ recieveError: ((P.Failure) -> Void)? = nil
) -> (P) -> Void where P: Publisher, P.Output == T, P.Failure == E {
    return { publisher in
        var subsciption: AnyCancellable?
        subsciption = publisher
            .sink(
                receiveCompletion: { competion in
                    switch(competion) {
                    case .finished:
                        subsciption?.cancel()
                        subsciption = nil
                    case let .failure(error):
                        recieveError?(error)
                    }
                },
                receiveValue: recieveValue
            )
    }
}

#endif
