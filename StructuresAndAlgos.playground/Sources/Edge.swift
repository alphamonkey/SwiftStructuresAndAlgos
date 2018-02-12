import Foundation

public enum EdgeType {
    case directed, undirected
}

public struct Edge<T:Hashable> {
    public var source:Vertex<T>
    public var destination:Vertex<T>
    public let weight:Double?
    /*
    public init(_ sourceVertex:Vertex<T>, _ destVertex:Vertex<T>) {
        self.source = sourceVertex
        self.destination = destVertex
        self.weight = nil
    }*/
}

extension Edge:Hashable {
    public var hashValue:Int {
        return "\(source)\(destination)\(weight ?? 0.0)".hashValue
    }
    public static func ==(lhs: Edge<T>, rhs:Edge<T>) -> Bool {
        return lhs.source == rhs.source &&
                lhs.destination == rhs.destination &&
                rhs.weight == rhs.weight
    }
}

extension Edge:CustomStringConvertible {
    public var description:String {
        return ("\(source) -> \(destination)")
    }
}
