import Foundation

public class Rule {
    
    public let triggerEvent: String
    
    public init(triggerEvent: String) {
        self.triggerEvent = triggerEvent
    }
    
    public func preconditionsFulfiled() -> Bool {
        return true
    }
    
    public func fulfill() -> Notification.Type? {
        return nil
    }
}