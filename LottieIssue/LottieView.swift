//
// Created for LottieIssue
// by  Stewart Lynch on 2022-12-26
// Using Swift 5.0
// Running on macOS 13.1
// 
// Folllow me on Mastodon: @StewartLynch@iosdev.space
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationName:String
    @Binding var play: Bool
    var animationView:LottieAnimationView
    init(animationName:String,
         play: Binding<Bool> = .constant(true)
    ) {
        self.animationName = animationName
        self.animationView = LottieAnimationView(name: animationName)
        self._play = play
    }
    class Coordinator: NSObject {
        @Binding var play: Bool
        let parent: LottieView
        init(parent: LottieView, play: Binding<Bool>) {
            self.parent = parent
            _play = play
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, play: $play)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if play {
            animationView.play { _ in
                play.toggle()
            }
        }
    }
}
