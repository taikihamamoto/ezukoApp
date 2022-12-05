//
//  fishAppearView.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/05.
//

import SwiftUI

struct fishAppearView: View {
    
    @EnvironmentObject var isSwitchView: User
    
    var body: some View {
        Button(action:{
            isSwitchView.flag = 2
        }){
        Text("タイトルに戻る")
        }
        
       
    }
}

struct fishAppearView_Previews: PreviewProvider {
    static var previews: some View {
        fishAppearView()
    }
}
