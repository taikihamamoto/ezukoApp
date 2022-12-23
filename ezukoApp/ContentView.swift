//
//  ContentView.swift
//  ezukoApp
//
//  Created by MacUser on 2022/12/02.
//

import SwiftUI

class User: ObservableObject {
    //初期値をタイトル画面に設定
    @Published var flag = 2
}

struct ContentView: View {
    
    @ObservedObject var isSwitchView = User()
    
    var body: some View {
        VStack {
            
            //プロローグ画面に遷移
            if isSwitchView.flag == 1 {
                prologView()
                    .environmentObject(isSwitchView)
            }
            
            //タイトル画面に遷移
            else if isSwitchView.flag == 2 {
                titleView()
                    .environmentObject(isSwitchView)
            }
            //マップ画面に遷移
            else if isSwitchView.flag == 3 {
                mapView()
                    .environmentObject(isSwitchView)
            }
            
            //図鑑画面に遷移
            else  if isSwitchView.flag == 4 {
                fishAppearView()
                    .environmentObject(isSwitchView)
            }
            //360度映像表示画面に遷移
            else  if isSwitchView.flag == 5 {
                cameraView()
                    .environmentObject(isSwitchView)
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
