//
//  mapView.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/05.
//

import SwiftUI




struct mapView: View {
    @EnvironmentObject var isSwitchView: User
    //写真を配列に
    let photo = [
        "IMG_1099",
        "IMG_1110",
        "IMG_1147"
    ]
    
    
    var body: some View {
        VStack {
            Text("クイズマップ")
            //タイトル画面に遷移
            Button(action:{
                isSwitchView.flag = 2
            }){
                Text("タイトルに戻る")
            }
            
            
            //位置情報取得
            Button("外来魚をさがす！") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            
            //魚のアイコンを押すと、360度カメラの映像が表示される
            Button(action:{
                isSwitchView.flag = 5
            }){
            Text("360度カメラ")
            }
            
            
            
        }
           
       
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}
