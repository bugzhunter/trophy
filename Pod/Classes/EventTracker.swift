import Foundation

public class EventTracker {
    
    public static let sharedInstance = EventTracker()
    
    public var rules: [Rule] = []
    
    private var pendingNotifications: [String: NotificationQueue] = [:]
    
    private var activeChannels: [String:NotificationChannel] = [:]
    
    public func track(event: String) {
        for rule in rules {
            if rule.triggerEvent == event && rule.preconditionsFulfiled() {
                let NotificationClass = rule.fulfill()
                if let Class = NotificationClass {
                    let notification = Class.init()
                    addPendingNotification(notification)
                    runPendingNotifications()
                }
            }
        }
    }

    
    public func startNotifications(channel: NotificationChannel) {
        activeChannels[channel.id] = channel
        runPendingNotifications()
    }
    
    public func stopNotifications(channelId: String) {
        activeChannels.removeValueForKey(channelId)
    }
    
    
    func runPendingNotifications() {
        for (channelId, queue) in pendingNotifications {
            if !queue.isBusy {
                runNextNotificationOnQueue(queue)
            }
        }
    }
    
    
    func addPendingNotification(notification: Notification) {
        let channelId = notification.getChannelId()
        let queue = pendingNotifications[channelId] ?? NotificationQueue(channelId: channelId)
        queue.notifications.append(notification)
        pendingNotifications[channelId] = queue
    }
    
    func runNextNotificationOnQueue(queue: NotificationQueue) {
        if let channel = activeChannels[queue.channelId] where queue.notifications.count > 0 {
            queue.isBusy = true
            let notification = queue.notifications.removeFirst()
            notification.completion = {
                queue.isBusy = false
                self.runNextNotificationOnQueue(queue)
            }
            notification.notify(channel)
        }
    }
}

class NotificationQueue {
    let channelId: String
    var notifications: [Notification] = []
    var isBusy: Bool = false
    
    init(channelId: String) {
        self.channelId = channelId
    }
}