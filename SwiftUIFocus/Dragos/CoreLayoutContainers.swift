//
//  CoreLayoutContainers.swift
//  SwiftUIFocus
//
//  Created by Dragos on 15.04.2025.
//

// HStack
// VStack
// ZStack
// Spacer, Divider
// Lazy - onAppear pe fiecare element print cu loaded
// AnyLayout - toggle H and V cu animatie
// ViewThatFits -

import SwiftUI

struct CoreLayoutContainers: View {

    @State private var colorsCount: Double = 3

    var body: some View {
        content
            .safeAreaInset(edge: .top) {
                Slider(value: $colorsCount, in: 0...20)
            }
            .toolbar {
                ToolbarItem {
                    Text(String(Int(colorsCount)))
                }
            }
    }

    private var content: some View {
        VStack {
            colors
        }
    }

    private var colors: some View {
        ForEach(0 ..< Int(colorsCount), id: \.self) { value in
            Color.random
                .overlay {
                    Text(String(value + 1))
                }
                .opacity(0.3)
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    NavigationStack {
        CoreLayoutContainers()
    }
    .border(.red)
}

extension Color {
    static var random: Color {
        Color(hue: .random(in: 0...1), saturation: 1, brightness: 1)
    }
}
