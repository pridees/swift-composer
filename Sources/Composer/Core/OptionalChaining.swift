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

precedencegroup OptionalChainingPrecedence {
    associativity: left
    higherThan: ApplicativePrecedence
}

infix operator <?> : OptionalChainingPrecedence

/// Optional chaingin operator
///
/// ## Usage
///
public func <?> <A, B, C> (_ a2b: @escaping (A) -> B, _ b2c: @escaping (B) -> C) -> (A?) -> C? {
    return { $0
        .map(a2b)
        .map(b2c)
    }
}

public func <?> <A, B, C> (_ a2b: @escaping (A) -> B?, _ b2c: @escaping (B) -> C?) -> (A?) -> C? {
    return { $0
        .flatMap(a2b)
        .flatMap(b2c)
    }
}
