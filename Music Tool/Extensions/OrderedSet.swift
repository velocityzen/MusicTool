public struct OrderedSet<E: Identifiable>: Equatable, Collection {
  public typealias Element = E
  public typealias Index = Int
  public typealias Indices = Range<Int>
  
  private var array: [Element]
  fileprivate var set: Set<Element.ID>
  
  /// Creates an empty ordered set.
  public init() {
    self.array = []
    self.set = Set()
  }
  
  /// Creates an ordered set with the contents of `array`.
  ///
  /// If an element occurs more than once in `element`, only the first one
  /// will be included.
  public init(_ array: [Element]) {
    self.init()
    for element in array {
      append(element)
    }
  }
  
  // MARK: Working with an ordered set
  /// The number of elements the ordered set stores.
  public var count: Int { return array.count }
  
  /// Returns `true` if the set is empty.
  public var isEmpty: Bool { return array.isEmpty }
  
  /// Returns the contents of the set as an array.
  public var contents: [Element] { return array }
  
  /// Returns `true` if the ordered set contains `member`.
  public func contains(_ member: Element) -> Bool {
    return set.contains(member.id)
  }
  
  public func get(_ id: Element.ID) -> Element? {
    return self.array.first(where: {$0.id == id})
  }
  
  /// Adds an element to the ordered set.
  ///
  /// If it already contains the element, then the set is unchanged.
  ///
  /// - returns: True if the item was inserted.
  @discardableResult
  public mutating func append(_ newElement: Element) -> Bool {
    let inserted = set.insert(newElement.id).inserted
    if inserted {
      array.append(newElement)
    }
    return inserted
  }
  
  @discardableResult
  public mutating func remove(_ id: Element.ID) -> Bool {
    let removed = set.remove(id) != nil
    if removed {
      let index = array.firstIndex(where: {$0.id == id})!
      array.remove(at: index)
    }
    
    return removed
  }
  
  public mutating func removeAll(_ ids: [Element.ID]) {
    set.subtract(ids)
    array.removeAll(where: { ids.contains($0.id) })
  }
  
  /// Remove and return the element at the beginning of the ordered set.
  public mutating func removeFirst() -> Element {
    let firstElement = array.removeFirst()
    set.remove(firstElement.id)
    return firstElement
  }
  
  /// Remove and return the element at the end of the ordered set.
  public mutating func removeLast() -> Element {
    let lastElement = array.removeLast()
    set.remove(lastElement.id)
    return lastElement
  }
  
  /// Remove all elements.
  public mutating func removeAll(keepingCapacity keepCapacity: Bool) {
    array.removeAll(keepingCapacity: keepCapacity)
    set.removeAll(keepingCapacity: keepCapacity)
  }
}

extension OrderedSet: ExpressibleByArrayLiteral {
  /// Create an instance initialized with `elements`.
  ///
  /// If an element occurs more than once in `element`, only the first one
  /// will be included.
  public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }
}

extension OrderedSet: RandomAccessCollection {
  public var startIndex: Int { return contents.startIndex }
  public var endIndex: Int { return contents.endIndex }
  public subscript(index: Int) -> Element {
    return contents[index]
  }
}

// !NOTE: OrseredSets are equal if they have the same elements ids
public func == <T>(lhs: OrderedSet<T>, rhs: OrderedSet<T>) -> Bool {
  return lhs.set == rhs.set
}

extension OrderedSet: Hashable where Element: Hashable { }

extension OrderedSet: Encodable where Element: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    for element in self.contents {
      try container.encode(element)
    }
  }
}

extension OrderedSet: Decodable where Element: Decodable {
  public init(from decoder: Decoder) throws {
    self.init()
    
    var container = try decoder.unkeyedContainer()
    while !container.isAtEnd {
      let element = try container.decode(Element.self)
      self.append(element)
    }
  }
}

