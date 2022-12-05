//
//  prologView.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/05.
//

import SwiftUI
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
    }
}
