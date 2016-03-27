import Foundation

public class Notification {
    
    typealias CompletionBlock = () -> Void
    var completion: CompletionBlock?
    
    public required init() {
    }
    
    public func getChannelId() -> String {
        return ""
    }
    
    public func notify(channel: NotificationChannel) {
        complete()
    }
    
    public func complete() {
        completion?()
    }
}

public class NotificationChannel {
    
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
    
}