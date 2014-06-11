OneTimeAlertController
============

This swift file lets you show alerts only 1 time to the user, like "Rate on the App Store", or alerts asking to modify app permissions, and other alerts that you only want to be displayed to the user once.

To Use
=======
1. Import the `OneTimeAlertController.swift` file into your project.
2. Create a `OneTimeAlertController` object and set the properties you'd normally set on a `UIAlertController` class.
3. Set the `identifier` property to a unique string.
4. Present the alert by calling the `presentFromViewController(viewController: UIViewController, animated: Bool, completion:(() -> Void)!)` method.
