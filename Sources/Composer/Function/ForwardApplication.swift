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

precedencegroup ForwardApplication  {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator |> : ForwardApplication

infix operator <| : ForwardApplication

public func |> <T1, T2>(_ t1: T1, _ f: @escaping (T1) -> T2) -> T2 {
    return f(t1)
}

public func |> <T1, T2>(_ t1: T1, _ f: @escaping (T1) throws -> T2) rethrows -> T2 {
    return try f(t1)
}

public func |> <T1>(_ t1: inout T1, _ f: @escaping (inout T1) throws -> Void) rethrows -> T1 {
    try f(&t1)
    return t1
}


@discardableResult
public func |> <T1: AnyObject>(_ t1: T1, _ f: @escaping (T1) throws -> Void) rethrows -> T1 {
    try f(t1)
    return t1
}

/// MARK: Inverted

public func <| <T1, T2>(_ f: @escaping (T1) -> T2, _ t1: T1) -> T2 {
    return f(t1)
}

public func <| <T1, T2>( _ f: @escaping (T1) throws -> T2, _ t1: T1) throws -> T2 {
    return try f(t1)
}

public func <| <T1>(_ f: @escaping (inout T1) throws -> Void, _ t1: inout T1) rethrows -> T1 {
    try f(&t1)
    return t1
}

@discardableResult
public func <| <T1: AnyObject>(_ f: @escaping (T1) throws -> Void, _ t1: T1) rethrows -> T1 {
    try f(t1)
    return t1
}
