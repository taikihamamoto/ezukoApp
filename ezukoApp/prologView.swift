//
//  prologView.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/05.
//

import SwiftUI
<<<<<<< HEAD
import AVKit


struct prologView: View {

    @EnvironmentObject var isSwitchView: User
    
    var body: some View {
        VStack {
            //動画情報
            let movieUrl = Bundle.main.url(forResource: "IMG_9590",withExtension:"MOV")!
            let avPlayer = AVPlayer(url: movieUrl)
            VideoPlayer(player: avPlayer)
            
            /* ContentView経由してないからエラー？
            Button(action:{
                isSwitchView.flag = 2
            }){
            Text("次へ")
            }
             */
            
        }
       
       
    }
    
    struct prologView_Previews: PreviewProvider {
        static var previews: some View {
            prologView()
        }
=======

struct prologView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct prologView_Previews: PreviewProvider {
    static var previews: some View {
        prologView()
>>>>>>> 8144ddd48f19cdb50bbbad9337f0b0d47d04b06d
    }
}
