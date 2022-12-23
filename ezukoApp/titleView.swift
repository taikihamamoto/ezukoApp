//
//  titleView.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/05.
//

import SwiftUI

struct titleView: View {
<<<<<<< HEAD
    
    @EnvironmentObject var isSwitchView: User
    
    var body: some View {
        VStack {
            
            
            Text("タイトル")
            
            //マップ画面に遷移
            Button(action:{
                isSwitchView.flag = 3
            }){
            Text("クイズマップ")
            }
                  
            //図鑑画面に遷移
            Button(action:{
                isSwitchView.flag = 4
            }){
            Text("ずかん")
            }
            
           
            
            
            
        }
    }
    
    struct titleView_Previews: PreviewProvider {
        static var previews: some View {
            titleView()
        }
=======
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct titleView_Previews: PreviewProvider {
    static var previews: some View {
        titleView()
>>>>>>> 8144ddd48f19cdb50bbbad9337f0b0d47d04b06d
    }
}
