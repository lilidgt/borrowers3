//
//  IntroView.swift
//  borrowers2.0
//
//  Created by Lissa Deguti on 01/08/25.
//

import SwiftUI

struct IntroView: View {
    @State private var step = 1
    @State var finishedTyping = false
    @State private var goToNextScene = false
    
    let texts = [
        "In our world,\nbeyond what we\nsee, hidden in\nsilence…\nLive tiny,\nsecret creatures.",
        "They hide close to\nour homes to borrow things. Like\nsugar or tea.",
        "We call them\nborrowers."
    ]
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.defaultBackground
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading, spacing: 24){
                    ForEach(0..<step, id: \.self) { index in
                        TypingTextView(
                            finalText: texts[index],
                            font: .custom("Baby Doll", size: 30)
                        ) {
                            //pra ele só mostrar a setinha quando o último texto acabar
                            //pega o texto anterior
                            if index == step - 1 {
                                finishedTyping = true
                            }
                        }
                    }
                    
                    if finishedTyping {
                        Image(systemName: "chevron.down")
                            .font(.title)
                            .foregroundStyle(.darkBrown)
                            .padding(.top, 10)
                    }
                }
                .frame(width: 300, alignment: .leading)
                
                NavigationLink(
                    destination: ObaachanDialogueSceneView(),
                    isActive: $goToNextScene,
                    label: {
                        EmptyView()
                    }
                )
            }
            .contentShape(Rectangle()) //pra poder clicar em qualquer lugar da tela
            .onTapGesture {
                if finishedTyping && step < texts.count {
                    step += 1
                    finishedTyping = false
                } else if finishedTyping && step >= texts.count {
                    goToNextScene = true
                }
            }        }
    }
}

#Preview {
    IntroView()
}
