//
//  Utilities.swift
//  testApp
//
//  Created by James on 1/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit
import GameKit

class Utilities : NSObject
{
    
    var gameCenterAvailable : Bool!
    var userAuthenticated : Bool!
    
    //singleton
    private struct Static
    {
        private static let instance :Utilities = Utilities()
    }
    
    class func sharedInstance() -> Utilities
    {
        return Static.instance
    }

    func isGameCenterAvailable() -> Bool
    {
        // check for presence of GKLocalPlayer API
        var gcClass: AnyClass! = NSClassFromString("GKLocalPlayer")
        return gcClass != nil
    }
    
    override init()
    {
        super.init()
        gameCenterAvailable = self.isGameCenterAvailable()
        if gameCenterAvailable != nil
        {
            var nc :NSNotificationCenter = NSNotificationCenter.defaultCenter()
            nc.addObserver(self, selector: "authenticationChanged", name: GKPlayerAuthenticationDidChangeNotificationName, object: nil)
        }
        
    }
    
    
    func authenticationChanged()
    {
        if GKLocalPlayer.localPlayer().authenticated && !userAuthenticated!
        {
            println("Authentication changed: player authenticated.")
            userAuthenticated = true
        } else if GKLocalPlayer.localPlayer().authenticated && userAuthenticated!
        {
            println("Authentication changed: player not authenticated")
            userAuthenticated = false
        }
    }
    
//    func authenticateLocalUser()
//    {
//        //        if !gameCenterAvailable!
//        //        { return
//        //        }
//        println("Authenticating local user...")
//        
//        if GKLocalPlayer.localPlayer().authenticated == false {
//            var localPlayer = GKLocalPlayer.localPlayer()
//            localPlayer.authenticateHandler = {(viewController : UIViewController!, error : NSError!) -> Void in
//                if ((viewController) != nil) {
//                   self.presentViewController(viewController, animated: true, completion: nil)
//                }else{
//                    
//                    println((GKLocalPlayer.localPlayer().authenticated))
//                }
//            }
//        } else
//        {
//            println("Already authenticated!")
//        }
//        
//    }

    
    
    
    
     
//    #pragma mark User functions
//    
//    - (void)authenticateLocalUser {
//    
//    if (!gameCenterAvailable) return;
//    
//    NSLog(@"Authenticating local user...");
//    if ([GKLocalPlayer localPlayer].authenticated == NO) {
//    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
//    } else {
//    NSLog(@"Already authenticated!");
//    }
//    }
//    
    
//    
//    - (id)init {
//        if ((self = [super init])) {
//            gameCenterAvailable = [self isGameCenterAvailable];
//            if (gameCenterAvailable) {
//                NSNotificationCenter *nc =
//                    [NSNotificationCenter defaultCenter];
//                [nc addObserver:self
//                    selector:@selector(authenticationChanged)
//                name:GKPlayerAuthenticationDidChangeNotificationName
//                object:nil];
//            }
//        }
//        return self;
//    }
//    
//    - (void)authenticationChanged {
//    
//    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
//    NSLog(@"Authentication changed: player authenticated.");
//    userAuthenticated = TRUE;
//    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
//    NSLog(@"Authentication changed: player not authenticated");
//    userAuthenticated = FALSE;
//    }
//    
//    }
    
    
//    
//    - (BOOL)isGameCenterAvailable {
//    // check for presence of GKLocalPlayer API
//    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
//    
//    // check if the device is running iOS 4.1 or later
//    NSString *reqSysVer = @"4.1";
//    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
//    options:NSNumericSearch] != NSOrderedAscending);
//    
//    return (gcClass && osVersionSupported);
//    }
    
    
    
}