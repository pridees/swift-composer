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

public func set<Root, Value>(
    _ keypath: WritableKeyPath<Root, Value>,
    _ value: Value
) -> (Root) -> Root {
    return { root in
        var copy = root
        copy[keyPath: keypath] = value
        return copy
    }
}

public func set<Root, Value>(
    _ keypath: WritableKeyPath<Root, Value>,
    _ value: Value
) -> (inout Root) -> Root {
    return { root in
        root[keyPath: keypath] = value
        return root
    }
}

public func set<Root, Value>(
    _ keypath: ReferenceWritableKeyPath<Root, Value>,
    _ value: Value
) -> (Root) -> Root where Root: AnyObject {
    return { root in
        root[keyPath: keypath] = value
        return root
    }
}
