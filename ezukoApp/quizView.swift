//
//  quizView.swift
//  ezukoApp
//
//  Created by 秋岡菜々子 on 2022/12/05.
//

import SwiftUI

class EnvironmentData: ObservableObject {
    @Published var isNavigationActive: Binding<Bool> = Binding<Bool>.constant(false)
}

struct quizView: View {
    
    @State var shouldShowSecondView: Bool = false
    @EnvironmentObject var envData: EnvironmentData
    
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                Text("クイズ")
                    .font(.largeTitle)
                    
                NavigationLink(destination: QuizView(), isActive: $shouldShowSecondView) {
                    EmptyView()
                }
                
                Button(action: {
                    shouldShowSecondView = true
                    envData.isNavigationActive = $shouldShowSecondView
                }){
                    Text("スタート")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                }
                .padding(.all)
                .background(Color.blue)
            }
        }
    }
}
 
struct QuizView: View {
    
    @State private var ShowQuizResultView: Bool = false
    
    var quiz = [
        "ウォーターキャベツはどっち",
        "駆除作業は誰が行っている？",
        "外来植物はどうやって持ち込まれた？"
    ]
    
    var answer = ["１", "国", "誰かが飼っていたものを捨てた"]
    
    var AnswerColumn = [
        ["１", "２", "３"],
        ["国", "民間", "どっちも"],
        ["国が公園を美しくするため", "誰かが飼っていたものを捨てた", "魚たちの餌のため"]
    ]
        
    @State var correctFlg = false
    @State var incorrectFlg = false
    @State var invalidBtn = false
    
    @State var quizNum = 0
    @State var quizScore = 0
    
    var randomNum = [0,1,2]
    
    init() {
        randomNum.shuffle()
        for i in 0..<quiz.count {
            AnswerColumn[i].shuffle()
        }
    }
    
    func CorrectAnswer(btnNum: Int) -> Bool {
        if AnswerColumn[randomNum[quizNum]][btnNum] == answer[randomNum[quizNum]] {
            return true
        }
        return false
    }
    
    func btnAction(count: Int) {
        //押されたボタンが正解かどうか
        if CorrectAnswer(btnNum: count) {
            self.correctFlg = true
            self.quizScore += 1
        } else {
            self.incorrectFlg = true
        }
        
        //一時的にボタンを無効にする
        self.invalidBtn = true
        
        
        
        //一秒後に画像を非表示にし、問題を進める
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.correctFlg = false
            self.incorrectFlg = false
            self.invalidBtn = false
            
            if quizNum == 2 {
                self.ShowQuizResultView = true
            } else {
                quizNum += 1
            }
        }
    }
        
    var body: some View {
        
        ZStack {
            VStack(spacing: 10) {
                Text("問題\(quizNum + 1)")
                    .font(.title)
                    .padding(.bottom, 30.0)
                
                Text(quiz[randomNum[quizNum]])
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 40.0)
                    .padding(.trailing, 40.0)
                    .frame(width: 400, height: 170, alignment: .top)
                
                ForEach(0..<3) { count in
                    Button(action: {
                        btnAction(count: count)
                    }) {
                        Text(AnswerColumn[randomNum[quizNum]][count])
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    .padding(.all)
                    .frame(width: 300, height: 80)
                    .background(Color.blue)
                    .disabled(invalidBtn)
                }
            }
            
            Text("⭕️")
                .scaledToFit()
                .frame(width: 1000.0, height: 1000.0)
                .visible(correctFlg)
            
            Text("❌")
                .scaledToFit()
                .frame(width: 1000.0, height: 1000.0)
                .visible(incorrectFlg)
                
        }
        .sheet(isPresented: $ShowQuizResultView) {
            QuizResultView(score: quizScore, quizCount: quiz.count)
        }
    }
}

struct QuizResultView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var envData: EnvironmentData
    
    let score: Int
    let quizCount: Int
    
    var body: some View {
        VStack {
            Text("結果")
                .font(.largeTitle)
                .padding(.bottom, 10.0)
            
            Text("\(score) / \(quizCount)")
                .font(.largeTitle)
                .padding(.bottom, 50.0)
            if score < 3{
                NavigationView{
                              NavigationLink("残念、動画へ進む", destination: descriptionVideoView())
                          }
            }
        }
    }
    
}

//struct QuizfalseView: View {
//
//    var body: some View {
//        NavigationView{
//            NavigationLink("残念、動画へ進む", destination: descriptionVideoView())
//        }
//    }
//}

//Viewを表示・非表示にする
struct VisibleModifier : ViewModifier {
    let visible:Bool
    @ViewBuilder
    func body(content: Content) -> some View {
        if visible == false {
            content.hidden()
        } else {
            content
        }
    }
}

extension View {
    func visible(_ visible:Bool) -> some View {
        modifier(VisibleModifier(visible: visible))
    }
}


struct quizView_Previews: PreviewProvider {
    static var previews: some View {
        quizView()
    }
}



//struct quizView: View {
//    @State private var descriptionVideoView: Bool = false
//
//    var body: some View {
//        if descriptionVideoView {
//            ezukoApp.descriptionVideoView()
//        } else {
//            Button {
//                descriptionVideoView.toggle()
//            } label: {
//                Text("フラグ切替")
//            }
//        }
//    }
//}
