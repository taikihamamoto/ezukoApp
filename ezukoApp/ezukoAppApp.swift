//
//  ezukoAppApp.swift
//  ezukoApp
//
//  Created by MacUser on 2022/12/02.
//

import SwiftUI

@main
struct ezukoAppApp: App {
    
    @UIApplicationDelegateAdaptor(MyAppDelgate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //prologView()
        }
    }
}


class MyAppDelgate: NSObject, UIApplicationDelegate {
    
   
   
    //起動時
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("didFinishLaunch")
        
        
       
        
        return true
    }
    
   
    
    //終了時
    func applicationWillTerminate(_ application: UIApplication) {
        print("willTerminate")
    }
}

