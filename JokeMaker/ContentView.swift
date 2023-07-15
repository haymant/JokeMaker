//
//  ContentView.swift
//  Jokes
//
//

import SwiftUI

struct Joke {
    var setup = ""
    var punchline = ""
}
struct ContentView: View {
    
    let jokes = [
        Joke(setup: "Why don't scientists trust atoms?", punchline: "Because they make up everything"),
        Joke(setup: "Why was the math book sad?", punchline: "Because it had too many problems"),
        Joke(setup: "Why did the tomato turn red?", punchline: "Because it saw the salad dressing"),
    ]
    
    @State private var showPunchline = false
    @State private var index = 0
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var isPositiveFeedback = true
    
    @State private var punchlineSize = 0.1
    @State private var punchlineRotation = Angle.degrees(0)
    
    var body: some View {
        ZStack {
            Color(.blue)
            VStack {
                Text(jokes[index].setup)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button {
                    // Action for when the main button is pressed
                    withAnimation {
                        showPunchline = true
                    }
                } label: {
                    Text("*What?* Tell me!")
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                if showPunchline {
                    Text(jokes[index].punchline)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .rotationEffect(punchlineRotation)
                        .scaleEffect(punchlineSize)
                        .onAppear {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.5)) {
                                punchlineSize = 1
                                punchlineRotation = .degrees(720)
                            }
                        }
                        .onDisappear {
                            punchlineSize = 0.1
                            punchlineRotation = .degrees(0)
                        }
                    
                    Text("Tap to continue")
                        .padding()
                        .foregroundColor(.gray)
                }
//                .opacity(showPunchline ? 1 : 0)
                
            }
            .padding()
        }
        .alert("Did you like the last joke???", isPresented: $showAlert) {
            Button("Yes!!!", role: .cancel) {
                // Action for when the "yes" button is pressed
                showSheet = true
                isPositiveFeedback = true
                print("YES!")
            }
            Button("Nooooo", role: .destructive) {
                // Action for when the "no" button is pressed
                showSheet = true
                isPositiveFeedback = false
                print("Bad user")
            }
        }
        .onTapGesture {
            // Action for when the user taps on the screen
            if showPunchline {
                index += 1
                if index == jokes.count {
                    index = 0
                }
                showPunchline = false
                showAlert = true
            }
        }
        .sheet(isPresented: $showSheet) {
            /*FeedbackView  (isPositiveFeedback: isPositiveFeedback)*/
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
