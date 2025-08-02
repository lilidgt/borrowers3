//
//  ObaachanDialogueSceneView.swift
//  borrowers2.0
//
//  Created by Lissa Deguti on 01/08/25.
//

import SwiftUI

struct ObaachanDialogueSceneView: View {
    @State private var stepIndex = 0
    @State var finishedTyping = false
    
    // animação da fala
    @State private var isTalking = false
    @State private var showFirstImage = true
    
    let steps: [ObaachanMinaDialogueStep] = [
        ObaachanMinaDialogueStep(narration: "In the agitated urban life, a little house still existed, and that’s where Mina and Obaachan lived, between the trees’ roots."),
        ObaachanMinaDialogueStep(narration: "Obaachan was sick, and needed medicine to get better — human medicine."),
        ObaachanMinaDialogueStep(speech: "Mina... Did you close the hatch behind the roots?", speaker: .obaachan),
        ObaachanMinaDialogueStep(speech: "Yes, Obaachan, no one saw me.", speaker: .mina),
        ObaachanMinaDialogueStep(speech: "Good, humans have been too close to our home lately. We have to be more careful.", speaker: .obaachan),
        ObaachanMinaDialogueStep(speech: "I know...", speaker: .mina)
    ]
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(alignment: .leading, spacing: 24) {
                    Group {
                        // narração
                        if let narration = steps[stepIndex].narration {
                            TypingTextView(
                                finalText: narration,
                                font: .custom("Baby Doll", size: 23)
                            ) {
                                finishedTyping = true
                            }
                            .padding(.top, 100)
                        }

                        // fala
                        if let speech = steps[stepIndex].speech {
                            VStack(alignment: .leading, spacing: 4) {
                                if let speaker = steps[stepIndex].speaker {
                                    Text(speaker == .obaachan ? "Obaachan:" : "Mina:")
                                        .font(.custom("Baby Doll", size: 20))
                                        .foregroundColor(Color("LightBrown"))
                                }

                                TypingTextView(
                                    finalText: speech,
                                    font: .custom("Baby Doll", size: 23)
                                ) {
                                    finishedTyping = true
                                }
                                .padding(.top, 10)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        startTalkingAnimation()
                                    }
                                }
                            }
                            .padding(.top, 100)
                        }
                    }
                    .id(stepIndex) // <- força reconstrução do bloco acima
                    
                    if finishedTyping {
                        Image(systemName: "chevron.down")
                            .font(.custom("Baby Doll", size: 23))
                            .opacity(0.6)
                            .padding(.top, 10)
                            .transition(.opacity)
                            .animation(.easeInOut, value: finishedTyping)
                    }
                }
                .frame(width: 300, alignment: .leading)
                .padding(.top, 90)
                
                Spacer()
                
                // personagens em narração
                if steps[stepIndex].narration != nil {
                    HStack(alignment: .center, spacing: 20) {
                        Image("mina_default")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        Image("obaachan_default")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    .padding(.bottom, 100)
                }
                
                // personagens em fala
                if steps[stepIndex].speech != nil {
                    HStack(alignment: .center, spacing: 20) {
                        Image(steps[stepIndex].speaker == .mina
                              ? (isTalking ? (showFirstImage ? "mina_talking1" : "mina_talking2") : "mina_default")
                              : "mina_default")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)

                        Image(steps[stepIndex].speaker == .obaachan
                              ? (isTalking ? (showFirstImage ? "obaachan_talking1" : "obaachan_talking2") : "obaachan_default")
                              : "obaachan_default")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    .padding(.bottom, 100)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if finishedTyping && stepIndex < steps.count - 1 {
                stepIndex += 1
                finishedTyping = false
                isTalking = false
                showFirstImage = true
            }
        }
    }
    
    func startTalkingAnimation(for duration: TimeInterval = 2) {
        isTalking = true
        var elapsed: TimeInterval = 0
        let interval: TimeInterval = 0.2

        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            showFirstImage.toggle()
            elapsed += interval

            if elapsed >= duration {
                timer.invalidate()
                isTalking = false
            }
        }
        showFirstImage = true
    }
}

#Preview {
    ObaachanDialogueSceneView()
}
