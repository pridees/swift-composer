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


precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator <> : SingleTypeComposition

public func <> <A>(f: @escaping (A) -> A, g: @escaping (A) -> A) -> (A) -> A {
    return f >>> g
}

public func <> <A>(f: @escaping (A) throws -> A, g: @escaping (A) throws -> A) -> (A) throws -> A {
    return f >>> g
}

public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> (inout A) -> Void {
    return { a in
        f(&a)
        g(&a)
    }
}

public func <> <A: AnyObject>(_ f: @escaping (A) -> Void, _ g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

public func apply<A>(_ funcs: ((A) -> A)...) -> (A) -> A {
    return { element in
        funcs.reduce(element) { el, transform in transform(el) }
    }
}

public func apply<A>(_ funcs: [(A) -> A]) -> (A) -> A {
    return { element in
        funcs.reduce(element) { el, transform in transform(el) }
    }
}

/// Apply vararg funcs
@inlinable
public func apply<A>(_ funcs: ((A) throws -> A)...) -> (A) throws -> A {
    return { element in
        try funcs.reduce(element) { el, transform in try transform(el) }
    }
}

/// Apply func sequence
@inlinable
public func apply<A>(_ funcs: [(A) throws -> A]) -> (A) throws -> A {
    return { element in
        try funcs.reduce(element) { el, transform in try transform(el) }
    }
}

public func apply<A>(_ funcs: ((inout A) -> Void)...) -> (inout A) -> Void {
    return { element in
        funcs.forEach { $0(&element) }
    }
}

public func apply<A>(_ funcs: ((inout A) throws -> Void)...) -> (inout A) throws -> Void {
    return { element in
        try funcs.forEach { try $0(&element) }
    }
}

public func apply<A: AnyObject>(_ funcs: ((A) -> Void)...) -> (A) -> Void {
    return { classObject in
        funcs.forEach { $0(classObject) }
    }
}

public func apply<A: AnyObject>(_ funcs: ((A) throws -> Void)...) -> (A) throws -> Void {
    return { classObject in
       try funcs.forEach { try $0(classObject) }
    }
}