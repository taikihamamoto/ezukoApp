//
//  VrScene.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/15.
//

import SwiftUI
import AVFoundation
import SceneKit
import SpriteKit
import CoreMotion

class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


/// VR動画を表示するクラス
class VrScene: SCNScene {
    /// 動画をループ再生する
    private var playerLooper: AVPlayerLooper?

    /// VR動画内での視点となるカメラ
    private let cameraNode: SCNNode

    /// 現在のカメラの位置
    private var currentDragVlaue: DragGesture.Value?
    
    override init() {
        cameraNode = SCNNode()
        super.init()

        // カメラ
        cameraNode.camera = SCNCamera()
        // カメラの向きが後ほど追加する動画の中央に向くように変更
        cameraNode.orientation = .init(0, 1, 0, 0)
        self.rootNode.addChildNode(cameraNode)

        // ループ動画プレイヤーの生成
        let urlPath = Bundle.main.path(forResource: "IMG_20221207_101138_00_324", ofType: "jpg")!
        let asset = AVAsset(url: URL(fileURLWithPath: urlPath))
        let playerItem = AVPlayerItem(asset: asset)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        queuePlayer.isMuted = true
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        
        // SKSceneを生成する
        let videoScene = SKScene(size: .init(width: 1920, height: 1080))
        // AVPlayerからSKVideoNodeの生成する
        let videoNode = SKVideoNode(avPlayer: queuePlayer)
        // シーンと同じサイズとし、中央に配置する
        videoNode.position = .init(x: videoScene.size.width / 2.0, y: videoScene.size.height / 2.0)
        videoNode.size = videoScene.size
        // 座標系を上下逆にする
        videoNode.yScale = -1.0
        videoNode.play()
        videoScene.addChild(videoNode)
        
        // カメラを囲う球体
        let sphere = SCNSphere(radius: 20)
        sphere.firstMaterial?.isDoubleSided = true
        sphere.firstMaterial?.diffuse.contents = videoScene
        let sphereNode = SCNNode(geometry: sphere)
        self.rootNode.addChildNode(sphereNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// カメラを回転させる
    func drag(value: DragGesture.Value) {
        // ドラッグの移動量を取得
        if currentDragVlaue?.startLocation != value.startLocation { currentDragVlaue = nil }
        let dragX = value.location.x - (currentDragVlaue?.location.x ?? value.startLocation.x)
        let dragY = value.location.y - (currentDragVlaue?.location.y ?? value.startLocation.y)

        // カメラを回転
        cameraNode.orientation = rotateCamera(
            q: cameraNode.orientation, // カメラの元々の姿勢
            point: cameraDragPoint(dragOffset: .init(x: dragX, y: dragY)) // ドラッグした距離を角度に変換
        )
        currentDragVlaue = value
    }
    
    
    /// スクロール幅のxy移動量を角度に変換
    private func cameraDragPoint(dragOffset: CGPoint) -> CGPoint {
        let angle = CGFloat(180)
        let x = (dragOffset.x / UIScreen.main.bounds.width) * angle
        let y = (dragOffset.y / UIScreen.main.bounds.height) * angle
        return .init(x: x, y: y)
    }
    
    /// カメラの回転値を取得
    private func rotateCamera(q: SCNQuaternion, point: CGPoint) -> SCNQuaternion {
        // カメラの元々の姿勢
        let current = GLKQuaternionMake(q.x, q.y, q.z, q.w)
        // y軸をドラッグのx移動量まで回転させる
        let width = GLKQuaternionMakeWithAngleAndAxis(GLKMathDegreesToRadians(Float(point.x)), 0, 1, 0)
        // x軸をドラッグのy移動量まで回転させる
        let height = GLKQuaternionMakeWithAngleAndAxis(GLKMathDegreesToRadians(Float(point.y)), 1, 0, 0)
        // 新しいカメラの姿勢を設定
        let qp  = GLKQuaternionMultiply(GLKQuaternionMultiply(width, current), height)
        return SCNQuaternion(qp.x, qp.y, qp.z, qp.w)
    }
}
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


/*
struct VrScene: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct VrScene_Previews: PreviewProvider {
    static var previews: some View {
        VrScene()
    }
}
*/
