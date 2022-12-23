//
//  mapView.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/05.
//

import SwiftUI

<<<<<<< HEAD



struct mapView: View {
    @EnvironmentObject var isSwitchView: User
   
    //@State var scale:CGFloat = 1.0
    //@State var initialScale: CGFloat = 1.0
    @GestureState var magnifyBy = 1.0


    var magnification: some Gesture {
            MagnificationGesture()
                .updating($magnifyBy) { currentState, gestureState, transaction in
                    gestureState = currentState
                }
        }

    
    
    var body: some View {
        /*
        let magnificationGesture = MagnificationGesture()
                    .onChanged { scale = $0 * initialScale }
                    .onEnded{ _ in initialScale = scale }
         */
        ScrollView([.vertical, .horizontal], showsIndicators: false) {
            
            
            VStack {
                Text("クイズマップ")
                //タイトル画面に遷移
                Button(action:{
                    isSwitchView.flag = 2
                }){
                    Text("タイトルに戻る")
                }
                
                ZStack {
                    Image("map-image")
                        .resizable()
                        .scaleEffect(magnifyBy)
                        .gesture(magnification)
                        
                    
                }
                
                
               
                
                //位置情報取得
                Button("外来魚をさがす！") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                
                //魚のアイコンを押すと、360度カメラの映像が表示される
                Button(action:{
                    isSwitchView.flag = 5
                    
                }){
                    Text("オオクチバス")
                }
                
                Button(action:{
                    isSwitchView.flag = 5
                }){
                    Text("ブラックバス")
                }
                
                
            }
            
        }
=======
struct mapView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
>>>>>>> 8144ddd48f19cdb50bbbad9337f0b0d47d04b06d
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}
