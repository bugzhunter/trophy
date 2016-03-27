import UIKit
import Trophy

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        EventTracker.sharedInstance.rules = [AppEnteredRule(triggerEvent: Events.AppEntered)]
        EventTracker.sharedInstance.track(Events.AppEntered)
        EventTracker.sharedInstance.track(Events.AppEntered)
        EventTracker.sharedInstance.track(Events.AppEntered)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        EventTracker.sharedInstance.startNotifications(ScreenNotificationChannel(id: "mainScreen", screenController: self))
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        EventTracker.sharedInstance.stopNotifications("mainScreen")
    }
    
}

