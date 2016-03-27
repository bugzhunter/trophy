import Foundation
import Trophy

class AppEnteredNotification: Notification {
    
    override func getChannelId() -> String {
        return  "mainScreen"
    }
    
    override func notify(channel: NotificationChannel) {
        if let channel = channel as? ScreenNotificationChannel {
            let alert = UIAlertController(title: "Hello User", message: "Application Entered!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                self.complete()
            }))
            channel.screenController.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}

class ScreenNotificationChannel: NotificationChannel {
    
    let screenController: UIViewController
    
    init(id: String, screenController: UIViewController) {
        self.screenController = screenController
        super.init(id: id)
    }
}