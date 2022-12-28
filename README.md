# Lottie Issue with SwiftUI
This project is a sample project with the code shown below.

I am trying to play a Lottie animation when some state updates in my SwiftUI view.
In the following code, the play button will play the animation on demand,  However, as soon as I introduce a state property that causes a refresh of the view, the animation stops playing.
Does anyone know how to solve this?

![LottieIssue](LottieIssue.gif)

## LottieView UIViewRepresentable

```` swift
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
````

## ContentView

```` swift
struct ContentView: View {
    @State private var play = false
    @State private var value = 0
    var body: some View {
        ZStack {
            VStack {
                Button("play") {
                    value += 1
                    play.toggle()
                }
                // Uncomment and this breaks
//                Text("The Value is \(value)")
                Rectangle()
                    .frame(width: 400, height: 400)
                    .foregroundColor(.clear)
                    .overlay {
                        LottieView(animationName: "confetti",
                                    play: $play)
                    }
            }
        }
    }
}
````
