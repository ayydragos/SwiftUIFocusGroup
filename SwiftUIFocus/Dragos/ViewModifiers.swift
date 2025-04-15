//
//  ViewModifiers.swift
//  SwiftUIFocus
//
//  Created by Dragos on 16.04.2025.
//

// random foreground
// fade in on appear
// reveal on tap

import SwiftUI

struct RandomForegroundModifier: ViewModifier {
    func body(content: Content) -> some View {

    }
}

struct FadeInOnAppearModifier: ViewModifier {
    func body(content: Content) -> some View {

    }
}

struct RevealOnTapModifier: ViewModifier {

    @State var isVisible = false

    func body(content: Content) -> some View {
        content
            .overlay {
                Color.clear
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 8))
                    .onTapGesture {
                        withAnimation {
                            isVisible = true
                        }
                    }
                    .opacity(isVisible ? 0 : 1)
            }
    }
}

#Preview {
    Text("some content")
        .modifier(RevealOnTapModifier())
}
