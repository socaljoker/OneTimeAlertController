//
//  OneTimeAlertController.swift
//  OneTimeAlertController
//
//  Created by Shawn Irvin on 6/10/14.
//
//

import UIKit

class OneTimeAlertController: UIAlertController {
    
    ///The identifier is used to determine if an alert is unique and whether it has already been shown or not. If the identifier is not set, it will be generated using the alert title, message, and action button titles, but is not guaranteed to be unique.
    var identifier:String {
        if !_identifier {
            _identifier = "\(title)\(message)"
            for action :AnyObject in actions {
                if let alertAction = action as? UIAlertAction {
                    _identifier = "\(identifier)\(alertAction.title)"
                }
            }
        }
        return _identifier!
    }
    var _identifier:String? = nil
    
    ///Only used internally
    var fileName:String {
        get{
            return "\(identifier).txt"
        }
    }
    
    class func documentURLForName(name:NSString) -> NSURL {
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as NSURL
        let fileURL = documentsDirectory.URLByAppendingPathComponent(name)
        
        return fileURL
    }
    
    func shouldPresentAlert() -> Bool {
        let alertShown = NSFileManager.defaultManager().fileExistsAtPath(OneTimeAlertController.documentURLForName(fileName).path)
        
        return !alertShown
    }
    
    class func shouldPresentAlert(identifier:String) -> Bool {
        let fileName = "\(identifier).txt"
        
        let alertShown = NSFileManager.defaultManager().fileExistsAtPath(OneTimeAlertController.documentURLForName(fileName).path)
        
        return !alertShown
    }
    
    func markAlertAsShown() -> Bool {
        if !NSFileManager.defaultManager().createFileAtPath(OneTimeAlertController.documentURLForName(fileName).path, contents: nil, attributes: nil) {
            #if DEBUG
                NSLog("Failed to create \(fileName).")
            #endif
            
            return false
        }
        else {
            return true
        }
    }
    
    //Call this function to mark an alert as shown if you didn't use the presentFromViewController method to present it
    class func markAlertAsShown(identifier:String) -> Bool {
        let fileName = "\(identifier).txt"
        
        if !NSFileManager.defaultManager().createFileAtPath(OneTimeAlertController.documentURLForName(fileName).path, contents: nil, attributes: nil) {
            #if DEBUG
                NSLog("Failed to create \(fileName).")
            #endif
            
            return false
        }
        else {
            return true
        }
    }
    
    ///Call this method to present the alert. It will check if the alert has been shown already, and not present it if so. If not, it will present it and mark that it was presented.
    func presentFromViewController(viewController: AnyObject, animated: Bool, completion:(() -> Void)!) {
        if self.shouldPresentAlert() {
            viewController.presentViewController?(self, animated: animated, completion: {
                    self.markAlertAsShown()
                    completion()
                })
        }
    }
}
