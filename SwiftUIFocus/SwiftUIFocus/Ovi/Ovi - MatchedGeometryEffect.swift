//
//  Ovi - MatchedGeometryEffect.swift
//  SwiftUIFocus
//
//  Created by Turda, Ovidiu on 16.04.2025.
//

import SwiftUI

enum GeometryEffect {}

extension GeometryEffect {
    struct ContentView: View {
        @State private var isProfileExpanded = false
        @Namespace private var profileAnimation

        @Namespace private var profileAvatar
        @Namespace private var profileName
        @Namespace private var profileJob

        var body: some View {
            VStack {
                if isProfileExpanded {
                    expandedProfileView
                } else {
                    collapsedProfileView
                }
                videoList
            }
        }

        var collapsedProfileView: some View {
            HStack {
                profileImage
                    .matchedGeometryEffect(id: profileAvatar, in: profileAnimation)
                    .frame(width: 60, height: 60)

                VStack(alignment: .leading) {
                    Text("Random iOS Youtuber")
                        .font(.title).bold()
                        .matchedGeometryEffect(id: profileName, in: profileAnimation)

                    Text("iOS Developer")
                        .foregroundColor(.secondary)
                        .matchedGeometryEffect(id: profileJob, in: profileAnimation)
                }

                Spacer()
            }
            .padding()
        }

        var expandedProfileView: some View {
            VStack {
                profileImage
                    .matchedGeometryEffect(id: profileAvatar, in: profileAnimation)
                    .frame(width: 130, height: 130)

                VStack {
                    Text("Random iOS Youtuber")
                        .font(.title).bold()
                        .matchedGeometryEffect(id: profileName, in: profileAnimation)

                    Text("iOS Developer")
                        .foregroundColor(.pink)
                        .matchedGeometryEffect(id: profileJob, in: profileAnimation)

                    Text("I went full-time content creation in July of 2019. I am focused on building my course business as well as my app, Some App.")
                        .padding()
                }
            }
            .padding()
        }

        var profileImage: some View {
            Image(systemName: "person.circle")
                .resizable()
                .clipShape(Circle())
                .onTapGesture {
                    withAnimation(.spring()) {
                        isProfileExpanded.toggle()
                    }
                }
        }

        var videoList: some View {
            List {
                ForEach(0...10, id: \.self) { _ in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 180)
                            .foregroundColor(.gray.opacity(0.2))

                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .opacity(0.3)
                    }
                    .padding(.vertical)

                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

#Preview("Matched geometry effect") {
    GeometryEffect.ContentView()
}
