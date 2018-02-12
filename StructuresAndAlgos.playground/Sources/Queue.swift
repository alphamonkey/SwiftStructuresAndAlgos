import Foundation

public struct Queue<T> {
    var array:[T]
    
    var isEmpty:Bool {
        get {
            return array.isEmpty
        }
    }
    
    var count:Int {
        get {
            return array.count
        }
    }
    
    var first:T? {
        get {
            return array.first
        }
    }
    
    var last:T? {
        get {
            return array.last
        }
    }
    public mutating func enqueue(_ object:T) {
        array.append(object)
    }
    
    public mutating func dequeue() -> T? {
        if let object = array.first {
            array.remove(at: 0)
            return object
        }
        return nil
    }
    
    
}

extension Queue:Sequence {
    public func makeIterator() -> QueueIterator<T> {
        return QueueIterator(queue: self)
    }
}
public struct QueueIterator<T>:IteratorProtocol {
    var queue:Queue<T>
    public mutating func next() -> T? {
        return queue.dequeue()
    }
}
