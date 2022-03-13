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


precedencegroup SingleTypePrecedence {
    associativity: left
}

infix operator <*> : SingleTypePrecedence

// MARK: - Immutable Apply Operator

public func <*> <T>(_ f: @escaping (T) -> T, _ g: @escaping (T) -> T) -> (T) -> T {
    return f >>> g
}

public func <*> <T>(_ f: @escaping (T) throws -> T, _ g: @escaping (T) throws -> T) -> (T) throws -> T {
    return f >=> g
}

// MARK: - InOut Apply Operator

public func <*> <T>(_ f: @escaping (inout T) -> Void, _ g: @escaping (inout T) -> Void)
-> (inout T) -> Void {
    return { a in
        f(&a)
        g(&a)
    }
}

public func <*> <T>(
    f: @escaping (inout T) throws -> Void,
    g: @escaping (inout T) throws -> Void
) -> (inout T) throws -> Void {
    return { a in
        try f(&a)
        try g(&a)
    }
}

// MARK: - AnyObject Apply Operator

public func <*> <T: AnyObject>(
    _ f: @escaping (T) -> Void,
    _ g: @escaping (T) -> Void
) -> (T) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

public func <*> <T: AnyObject>(
    _ f: @escaping (T) throws -> Void,
    _ g: @escaping (T) throws -> Void
) -> (T) throws -> Void {
    return { a in
        try f(a)
        try g(a)
    }
}
