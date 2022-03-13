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

// MARK: - Product type Monoid

public struct Product<A: Numeric> {
    public let value: A
    
    public init(_ value: A) {
        self.value = value
    }
}

extension Product: ExpressibleByIntegerLiteral where A: Monoid {
    public typealias IntegerLiteralType = A.IntegerLiteralType
    
    public static var empty: A { 1 }
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.value = A(integerLiteral: value)
    }
    
    public static func <> (lhs: Self, rhs: Self) -> Self {
        Product<A>(lhs.value + rhs.value)
    }
}

extension Product: ExpressibleByFloatLiteral where A: ExpressibleByFloatLiteral & Monoid {
    public typealias FloatLiteralType = A.FloatLiteralType
    
    public static var empty: A { 1.0 }

    public init(floatLiteral value: A.FloatLiteralType) {
        self.value = A(floatLiteral: value)
    }
    
    public static func <> (lhs: Self, rhs: Self) -> Self {
        Product<A>(lhs.value * rhs.value)
    }
}
