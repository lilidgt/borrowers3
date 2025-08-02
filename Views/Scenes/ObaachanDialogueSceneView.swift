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
    
    @State private var isTalking = false
    @State private var showFirstImage = true
    
    @State private var goToNextScene = false
    
    @State private var steps: [DialogueStep] = [
        DialogueStep(narration: "In the agitated urban life, a little house still existed, and that’s where Mina and Obaachan lived, between the trees’ roots."),
        DialogueStep(narration: "Obaachan was sick, and needed medicine to get better — human medicine."),
        DialogueStep(speech: "Mina... Did you close the hatch behind the roots?", speaker: .obaachan),
        DialogueStep(speech: "Yes, Obaachan, no one saw me.", speaker: .mina),
        DialogueStep(speech: "Good, humans have been too close to our home lately. We have to be more careful.", speaker: .obaachan),
        DialogueStep(speech: "I know...", speaker: .mina),
        DialogueStep(circles: "..."),
        DialogueStep(choices: "Should Mina tell Obaachan she’s going to the human’s house to get the medicine?")
    ]
    
    let tellObaachanSteps: [DialogueStep] = [
        DialogueStep(speech: "If you’re truly set on going, Mina…", speaker:.obaachan),
        DialogueStep(speech: "I still remember that little blue bottle… it smelled just like tulips…", speaker:.obaachan),
        DialogueStep(speech: "I’ll find it, Obaa. I promise.", speaker: .mina)
    ]

    let keepQuietSteps: [DialogueStep] = [
        DialogueStep(speech: "It’s getting late. Try to sleep now, Obaachan. Good night…", speaker: .mina)
    ]
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(alignment: steps[stepIndex].speaker == .obaachan ? .trailing : .leading, spacing: 24) {
                    Group {
                        // 3 pontos
                        if let circles = steps[stepIndex].circles {
                            TypingTextView(
                                finalText: circles,
                                font: .custom("Baby Doll", size: 24)
                            ) {
                                finishedTyping = true
                            }
                            .padding(.top, 60)
                        }

                        // narração
                        if let narration = steps[stepIndex].narration {
                            TypingTextView(
                                finalText: narration,
                                font: .custom("Baby Doll", size: 24)
                            ) {
                                finishedTyping = true
                            }
                            .padding(.top, 60)
                        }

                        // fala
                        if let speech = steps[stepIndex].speech {
                            VStack(alignment: steps[stepIndex].speaker == .obaachan ? .trailing : .leading, spacing: 4) {
                                if let speaker = steps[stepIndex].speaker {
                                    Text(speaker == .obaachan ? "Obaachan:" : "Mina:")
                                        .font(.custom("Baby Doll", size: 21))
                                        .foregroundColor(Color("LightBrown"))
                                }

                                TypingTextView(
                                    finalText: speech,
                                    font: .custom("Baby Doll", size: 24)
                                ) {
                                    finishedTyping = true
                                }
                                .padding(.top, 10)
                                .onAppear {
                                    startTalkingAnimation()
                                }
                            }
                            .padding(.top, 60)
                        }
                        
                        //escolha
                        if let question = steps[stepIndex].choices {
                            TypingTextView(
                                finalText: question,
                                font: .custom("Baby Doll", size: 21)
                            ) {
                                finishedTyping = true
                            }
                            .padding(.top, 60)
                            
                            HStack(spacing: 4) {
                                Button(action: {
                                    print("Escolha: Tell Obaachan")
                                    withAnimation {
                                        steps.append(contentsOf: tellObaachanSteps)
                                        stepIndex += 1
                                        finishedTyping = false
                                        isTalking = false
                                        showFirstImage = true
                                    }
                                }) {
                                    TypingTextView(
                                        finalText: "Tell Obaachan",
                                        font: .custom("Baby Doll", size: 18),
                                        color: .defaultBackground
                                    )
                                    .padding(.vertical, 12)
                                    .frame(width: 160)
                                    .background(Color("DarkBrown"))
                                    .cornerRadius(12)
                                }

                                Button(action: {
                                    print("Escolha: Keep quiet")
                                    withAnimation {
                                        steps.append(contentsOf: keepQuietSteps)
                                        stepIndex += 1
                                        finishedTyping = false
                                        isTalking = false
                                        showFirstImage = true
                                    }
                                }) {
                                    TypingTextView(
                                        finalText: "Keep quiet",
                                        font: .custom("Baby Doll", size: 18),
                                        color: .defaultBackground
                                    )
                                    .padding(.vertical, 12)
                                    .frame(width: 160)
                                    .background(Color("DarkBrown"))
                                    .cornerRadius(12)
                                }                            }
                            .padding(.top, 8)
                        }
                    }
                    .id(stepIndex)
                    
                    if finishedTyping && steps[stepIndex].choices == nil{
                        Image(systemName: "chevron.down")
                            .font(.title)
                            .foregroundStyle(.darkBrown)
                            .padding(.top, 10)
                    }
                }
                .frame(width: 300, alignment: steps[stepIndex].speaker == .obaachan ? .trailing : .leading)
                .padding(.top, 90)
                
                Spacer()
                
                //3 pontos ou escolha
                if steps[stepIndex].circles != nil || steps[stepIndex].choices != nil{
                    HStack(alignment: .center, spacing: 20) {
                        Image("mina_worried")
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
                
                //narração
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
                
                //speech
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
            NavigationLink(
                destination: PathChoicesView(), // substitui pelo nome da próxima tela
                isActive: $goToNextScene,
                label: { EmptyView() }
            )
            .hidden()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if finishedTyping && stepIndex < steps.count - 1 && steps[stepIndex].choices == nil{
                stepIndex += 1
                finishedTyping = false
                isTalking = false
                showFirstImage = true
            } else if finishedTyping && stepIndex >= steps.count - 1 && steps[stepIndex].choices == nil {
                goToNextScene = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func startTalkingAnimation(for duration: TimeInterval = 2.5) {
        isTalking = true
        showFirstImage = true
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
    }
}

#Preview {
    ObaachanDialogueSceneView()
}
