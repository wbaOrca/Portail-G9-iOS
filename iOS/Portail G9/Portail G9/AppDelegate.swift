//
//  AppDelegate.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import CoreData

import Firebase
import UserNotifications
import FirebaseMessaging
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    let gcmMessageIDKey = "body"
    let subscriptionTopic = "global"

    // ***********************************
    // ***********************************
    // ***********************************
    // ***********************************
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //fireBase
        FirebaseApp.configure()
        
        //FCM cloud messaging
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        
        //keyboard manager
        IQKeyboardManager.shared.enable = true
        
        return true
    }

    // ***********************************
    // ***********************************
    // ***********************************
    // ***********************************
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    // ***********************************
    // ***********************************
    // ***********************************
    // ***********************************
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    // ***********************************
    // ***********************************
    // ***********************************
    // ***********************************
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    // ***********************************
    // ***********************************
    // ***********************************
    // ***********************************
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        UIApplication.shared.applicationIconBadgeNumber  = 0
        connectToFcm()
    }

    // ***********************************
    // ***********************************
    // ***********************************
    // ***********************************
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Split view

    
    
    // MARK: - Core Data stack

    // ***********************************
    // ***********************************
    // ***********************************
    // ***********************************
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Portail_G9")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    // ***********************************
    // ***********************************
    // ***********************************
    // ***********************************
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}



// ++++++++++++++++++
// ++++++++++++++++++
// ++++++++++++++++++
extension AppDelegate : UNUserNotificationCenterDelegate , MessagingDelegate
{
    
    //*****
    //******
    //*******
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        if let apsNotif = userInfo["aps"] as? NSDictionary {
            
            if let alertDict = apsNotif["alert"] as? NSDictionary {
                
                let body : String = alertDict["body"] as! String
                let title : String = alertDict["title"] as! String
                
                
                let topWindow = UIWindow(frame: UIScreen.main.bounds)
                topWindow.rootViewController = UIViewController()
                topWindow.windowLevel = UIWindow.Level.alert + 1
                let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                    // continue your work
                    // important to hide the window after work completed.
                    // this also keeps a reference to the window until the action is invoked.
                    topWindow.isHidden = true
                }))
                topWindow.makeKeyAndVisible()
                topWindow.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
            
        }
        print("Handle push from background or closed")
        UIApplication.shared.applicationIconBadgeNumber  = 0
        // Change this to your preferred presentation option
        completionHandler([])
    }
    //*****
    //******
    //*******
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        
        // Print message ID.
        if let apsNotif = userInfo["aps"] as? NSDictionary {
            
            if let alertDict = apsNotif["alert"] as? NSDictionary {
                
                let body : String = alertDict["body"] as! String
                let title : String = alertDict["title"] as! String
                
                
                let topWindow = UIWindow(frame: UIScreen.main.bounds)
                topWindow.rootViewController = UIViewController()
                topWindow.windowLevel = UIWindow.Level.alert + 1
                let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                    // continue your work
                    // important to hide the window after work completed.
                    // this also keeps a reference to the window until the action is invoked.
                    topWindow.isHidden = true
                }))
                topWindow.makeKeyAndVisible()
                topWindow.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
            
        }
        print("Handle push from background or closed")
        UIApplication.shared.applicationIconBadgeNumber  = 0
        
        completionHandler()
    }
    
    //*****
    //******
    //*******
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
        let d : [String : Any] = remoteMessage.appData["notification"] as! [String : Any]
        let body : String = d["body"] as! String
        let title : String = d["title"] as! String
        
        
        print("FIRMessagingDelegate == ", body + title)
        
        
        let content = UNMutableNotificationContent()
        let requestIdentifier = "PortailG9Notification"
        
        content.badge = 1
        content.title = "Portail G9"
        content.subtitle = "Renault"
        content.body = body
        content.categoryIdentifier = "actionCategory"
        content.sound = UNNotificationSound.default
        
        if #available(iOS 12.0, *) { }else {
            
            content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
            // If you want to attach any image to show in local notification
            let url = Bundle.main.url(forResource: "logo_lizmer", withExtension: "png")
            do {
                let attachment = try? UNNotificationAttachment(identifier: requestIdentifier, url: url!, options: nil)
                content.attachments = [attachment!]
            }
        }
        
        
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error:Error?) in
            if error != nil {
                print(error?.localizedDescription ?? "-- error.localizedDescription --")
            }
            print("Notification Register Success")
        }
    }
    
    
    
    //****************************
    //****************************
    //****************************
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        // print("Notification didReceiveRemoteNotification fetchCompletionHandler 11")
        
        completionHandler(UIBackgroundFetchResult.newData)
        
        UIApplication.shared.applicationIconBadgeNumber  = UIApplication.shared.applicationIconBadgeNumber + 1
    }
    
    
    // *****************************************
    // *****************************************
    // ****** didReceiveRemoteNotification
    // *****************************************
    // *****************************************
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // print("Notification didReceiveRemoteNotification 22")
        
    }
    // ****************************
    // ****************************
    // ****************************
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        
        Messaging.messaging().subscribe(toTopic: self.subscriptionTopic);
    }
    
    // ****************************
    // ****************************
    // ****************************
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        Messaging.messaging().apnsToken = deviceToken as Data
        
        Messaging.messaging().subscribe(toTopic: self.subscriptionTopic);
    }
    
    
    // *****************************************
    // *****************************************
    // ****** connectToFcm
    // *****************************************
    // *****************************************
    // [START connect_to_fcm]
    func connectToFcm() {
       
        // Disconnect previous FCM connection if it exists.
        //Messaging.messaging().shouldEstablishDirectChannel = false
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        Messaging.messaging().subscribe(toTopic: self.subscriptionTopic);
        
    }
    // [END connect_to_fcm]
    // *****************************************
    // *****************************************
    // ****** didFailToRegisterForRemoteNotificationsWithError
    // *****************************************
    // *****************************************
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // *****************************************
    // *****************************************
    // ****** didRegisterForRemoteNotificationsWithDeviceToken
    // *****************************************
    // *****************************************
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the InstanceID token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)
        // FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.prod)
        
    }
}
