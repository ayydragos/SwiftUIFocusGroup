//
//  ViewLifecycle.swift
//  SwiftUIFocus
//
//  Created by Turda, Ovidiu on 15.04.2025.
//

import SwiftUI

enum ViewLifecycle {}

extension ViewLifecycle {
    struct LifecycleObservingView: View {
        @State private var appearCount = 0
        @State private var updateCount = 0

        var body: some View {
            VStack {
                Text("Appeared: \(appearCount) times")
                Text("Updated: \(updateCount) times")

                Button("Trigger Update") {
                    updateCount += 1
                }
            }
            .onAppear {
                print("View appeared")
                appearCount += 1
            }
            .onDisappear {
                print("View disappeared")
            }
        }
    }
}

extension ViewLifecycle {
    struct StateUpdateView: View {
        @State private var counter = 0
        @State private var lastUpdateTime = Date()

        var body: some View {
            VStack {
                Text("Counter: \(counter)")
                Text("Last update: \(lastUpdateTime.formatted())")

                Button("Increment") {
                    counter += 1
                    lastUpdateTime = Date()
                }
            }
            .onChange(of: counter) { newValue in
                print("Counter changed to: \(newValue)")
            }
        }
    }
}

extension ViewLifecycle {
    struct ParentView: View {
        @State private var showChild = false

        var body: some View {
            VStack {
                Toggle("Show Child", isOn: $showChild)

                if showChild {
                    ChildView()
                        .transition(.opacity)
                }
            }
            .onAppear { print("Parent appeared") }
            .onDisappear { print("Parent disappeared") }
        }
    }
    struct ChildView: View {
        var body: some View {
            Text("Child View")
                .onAppear { print("Child appeared") }
                .onDisappear { print("Child disappeared") }
        }
    }
}

extension ViewLifecycle {
    struct AsyncLifecycleView: View {
        @State private var data: String = "Loading..."

        var body: some View {
            Text(data)
                .task {
                    // Simulating async work
                    try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                    data = "Data loaded!"
                }
        }
    }
}

extension ViewLifecycle {
    struct IdentityDemoView: View {
        @State private var items = ["A", "B", "C"]
        @State private var showItems = true

        var body: some View {
            VStack {
                Toggle("Show Items", isOn: $showItems)

                if showItems {
                    ForEach(items, id: \.self) { item in
                        ItemView(title: item)
                    }
                }

                Button("Shuffle") {
                    items.shuffle()
                }
            }
        }
    }
    struct ItemView: View {
        let title: String
        @State private var tapCount = 0

        var body: some View {
            Button("\(title): Tapped \(tapCount) times") {
                tapCount += 1
            }
            .onAppear { print("\(title) appeared") }
            .onDisappear { print("\(title) disappeared") }
        }
    }
}

extension ViewLifecycle {
    struct LifecycleView: View {
        @State private var appearances = 0
        @State private var updates = 0

        var body: some View {
            VStack {
                Text("Appeared \(appearances) times")
                Text("Updated \(updates) times")
                Button("Update") { updates += 1 }
            }
            .onAppear {
                appearances += 1
                print("View appeared")
            }
            .onDisappear {
                print("View disappeared")
            }
            .task {
                print("Task started on view appearance")
            }
        }
    }
}

extension ViewLifecycle {
    struct IdentityExample: View {
        @State private var items = [1, 2, 3]

        var body: some View {
            VStack {
                // Correct: Stable identities preserve state
                ForEach(items, id: \.self) { item in
                    CounterWithId(id: item)
                }

                Spacer()

                // Problematic: Using array indices can cause view recycling
                ForEach(0..<items.count) { index in
                    CounterWithId(id: items[index])
                }

                Button("Shuffle") {
                    items.shuffle()
                }

                Spacer()
            }
        }
    }
}

extension ViewLifecycle {
    struct CounterWithId: View {
        let id: Int
        @State private var taps = 0

        var body: some View {
            Button("Item \(id): \(taps) taps") {
                taps += 1
            }
            .onAppear {
                print("Item \(id) appeared")
            }
            .onDisappear {
                print("Item \(id) disappeared")
            }
        }
    }
}

#Preview("Basic Lifecycle Observation") {
    ViewLifecycle.LifecycleObservingView()
}

#Preview("State Updates with Timestamp") {
    ViewLifecycle.StateUpdateView()
}

#Preview("Parent-Child Lifecycle") {
    ViewLifecycle.ParentView()
}

#Preview("Async Loading Lifecycle") {
    ViewLifecycle.AsyncLifecycleView()
}

#Preview("Identity and State Preservation") {
    ViewLifecycle.IdentityDemoView()
}

#Preview("Appearance and Update Counting") {
    ViewLifecycle.LifecycleView()
}

#Preview("Identity Impact on State") {
    ViewLifecycle.IdentityExample()
}
