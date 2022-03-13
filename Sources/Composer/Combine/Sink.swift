//
//  File.swift
//  
//
//  Created by Alex O on 13.03.2022.
//

import Foundation

#if canImport(Combine)
import Combine

public func fireOnce<P, T>(
    _ completion: @escaping (T) -> Void
) -> (P) -> Void where P: Publisher, P.Output == T, P.Failure == Never {
    return { publisher in
        var subsciption: AnyCancellable?
        subsciption = publisher
            .handleEvents(receiveCompletion: { _ in
                subsciption?.cancel()
                subsciption = nil
            })
            .sink(receiveValue: completion)
    }
}

#endif
