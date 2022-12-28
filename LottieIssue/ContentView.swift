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
                Text("The Value is \(value)")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
