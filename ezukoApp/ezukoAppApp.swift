//
//  ezukoAppApp.swift
//  ezukoApp
//
//  Created by MacUser on 2022/12/02.
//

import SwiftUI

@main
//struct ezukoAppApp: App {
//    var body: some Scene {
//        WindowGroup {
//            quizView()
//        }
//    }
//}

//ここは自分のアプリ名
struct ezukoAppApp: App {
var body: some Scene {
   WindowGroup {
       quizView().environmentObject(EnvironmentData())
   }
}
}
