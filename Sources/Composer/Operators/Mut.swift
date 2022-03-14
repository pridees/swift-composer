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

/// Protocol with single default method
/// it makes new copy and change object
///
/// Call the function `mutate(_ closure: (inout Self) -> Void) -> Self`
///
/// Usage
/// ```swift
/// struct User: Mutable {
///     let name: String
///     let age: Int
/// }
///
/// let user = User(name: "John", age: 10)
///
/// let updatedUser = user.mutate { user in
///     user.name = "Mitch"
/// }
///
/// updatedUser // { name: "Mitch", age: 10 }
/// ```
public protocol Mutable {}

extension Mutable {
    /// Gets closure which passing inout Struct ref
    ///
    /// - Parameter closure: (inout Self) -> Void
    ///
    /// - Returns: Self
    ///
    public func mutate(_ f: @escaping (inout Self) -> Void) -> Self {
        self |> mut(f)
    }
}

public func mut<A>(_ f: @escaping (inout A) -> Void) -> (A) -> A {
    return {
        var copy = $0
        f(&copy)
        return copy
    }
}

public func mut<A: AnyObject>(_ f: @escaping (inout A) -> Void) -> (inout A) -> A {
    return {
        f(&$0)
        return $0
    }
}
