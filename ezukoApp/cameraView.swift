//
//  cameraView.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/15.
//

import SwiftUI
import SceneKit

struct cameraView: View {
    @EnvironmentObject var isSwitchView: User
    let vrScene = VrScene()
    var body: some View {
        SceneView(scene: vrScene)
            .gesture(
                DragGesture()
                    .onChanged(vrScene.drag(value:))
            )
        
    }
}

struct cameraView_Previews: PreviewProvider {
    static var previews: some View {
        cameraView()
    }
}
