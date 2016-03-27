import Foundation
import Trophy

class AppEnteredRule: Rule {
    
    override func fulfill() -> Notification.Type? {
        return AppEnteredNotification.self
    }
    
}