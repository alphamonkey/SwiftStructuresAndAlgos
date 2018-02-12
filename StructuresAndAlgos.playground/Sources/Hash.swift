import Foundation

public func naiveHash(_ string:String) -> Int {
    let unicodeScalars = string.unicodeScalars.map { Int($0.value)}
    return unicodeScalars.reduce(0, +)
}

public func djb2Hash(_ string:String) -> Int {
    let unicodeScalars = string.unicodeScalars.map { Int($0.value)}
    return unicodeScalars.reduce(5381) {
        abs(($0 << 5) &+ $0 &+ Int($1)) % string.count
    }
}

public struct HashTable<Key:Hashable, Value> {
    private typealias Element = (key:Key, value:Value)
    private typealias Bucket = [Element]
    private var buckets:[Bucket]
    
    private(set) public var count = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    public init(capacity:Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating:[], count:capacity)
        
    }
    
    public func index(for key:Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
    
    public subscript(key:Key) -> Value? {
        get {
            return value(for:key)
        }
        
        set {
            if let value = newValue {
                update(value:value, for:key)
            }
            else {
                removeValue(for:key)
            }
        }
    }
    @discardableResult
    public mutating func removeValue(for key:Key) -> Value? {
        let index = self.index(for:key)
        
        if let(i, element) = buckets[index].enumerated().first(where:{$0.1.key == key}) {
            buckets[index].remove(at: i)
            count -= 1
            return element.value
        }
        return nil
    }
    @discardableResult
    public mutating func update(value:Value, for key:Key) -> Value? {
        let index = self.index(for: key)

        if let (i, element) = buckets[index].enumerated().first(where: {$0.1.key == key}) {
            let oldValue = element.value
            buckets[index][i].value = value
            return oldValue
        }
        buckets[index].append((key:key, value:value))
        
        count += 1
        return nil
    }
    public func value(for key:Key) -> Value? {
        let index = self.index(for: key)
        return buckets[index].first {$0.key == key}?.value
    }
}
