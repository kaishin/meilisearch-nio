import Foundation

public func pipe<A>(
  _ f: @escaping (A) -> A,
  _ g: @escaping (A) -> A
) -> (A) -> A {
  { (a: A) -> A in
    g(f(a))
  }
}

public func pipe<A>(
  _ f: @escaping (A) -> A,
  _ g: @escaping (A) -> A,
  _ h: @escaping (A) -> A
) -> (A) -> A {
  { (a: A) -> A in
    h(g(f(a)))
  }
}

public func pipe<A>(
  _ f: @escaping (A) -> A,
  _ g: @escaping (A) -> A,
  _ h: @escaping (A) -> A,
  _ i: @escaping (A) -> A
) -> (A) -> A {
  { (a: A) -> A in
    i(h(g(f(a))))
  }
}

public func pipe<A>(
  _ f: @escaping (A) throws -> A,
  _ g: @escaping (A) throws -> A
) -> (A) throws -> A {
  { (a: A) throws -> A in
    try g(f(a))
  }
}

public func pipe<A>(
  _ f: @escaping (A) throws -> A,
  _ g: @escaping (A) throws -> A,
  _ h: @escaping (A) throws -> A
) -> (A) throws -> A {
  { (a: A) throws -> A in
    try h(g(f(a)))
  }
}

public func pipe<A>(
  _ f: @escaping (A) throws -> A,
  _ g: @escaping (A) throws -> A,
  _ h: @escaping (A) throws -> A,
  _ i: @escaping (A) throws -> A
) -> (A) throws -> A {
  { (a: A) throws -> A in
    try i(h(g(f(a))))
  }
}
