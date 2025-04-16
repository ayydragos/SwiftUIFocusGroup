//
//  4.PropertyWrappers.swift
//  SwiftUIFocus
//
//  Created by Fechete, Dragos on 16.04.2025.
//

import SwiftUI

// @ObservedObject
// @StateObject
// @Observable - swift 5.9

//class ViewModel: ObservableObject {
//    @Published var first: Int
//    @Published var second: Int
//
//    init() {
////        first = .random(in: 0...30)
////        second = .random(in: 0...30)
//        first = 1
//        second = 1
//        print(#function + " \(first) \(second)")
//    }
//
//    deinit {
//        print(#function +  " \(first) \(second)")
//    }
//
//    func increment() {
//        first += 1
//        second += 1
//    }
//}



struct ParentView: View {

//    @StateObject var viewModel = Singleton.shared

    var body: some View {
        let _ = Self._printChanges()
        Text("Parent \(Singleton.shared.value)")
        ChildView(singleton: Singleton.shared)
    }
}

struct ChildView: View {

//    @ObservedObject var viewModel: ViewModel

    @ObservedObject var singleton: Singleton

    init(singleton: Singleton) {
        self.singleton = singleton
    }
//    init(viewModel: ViewModel) {
//        self._viewModel = StateObject(wrappedValue: viewModel)
//    }

    var body: some View {
        let _ = Self._printChanges()
        Text("Child \(singleton.value)")
        Button("Plus") {
            singleton.value += 1
        }

    }
}

class Singleton: ObservableObject {
    static var shared = Singleton()
    private init() { self.value = 1 }
    @Published var value: Int
}

#Preview {
    @Previewable @State var viewId = UUID()

    ParentView()
        .id(viewId)
    Button("refresh") { viewId = UUID() }
}
