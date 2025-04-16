//
//  Ovi - StateManagement.swift
//  SwiftUIFocus
//
//  Created by Turda, Ovidiu on 16.04.2025.
//

import SwiftUI

enum StateManagement {}

extension StateManagement {
    struct ContactHeader: View {
        // Simple read-only stored properties
        let photo: Image
        let name: String
        let title: String

        var body: some View {
            VStack(spacing: 8) {
                photo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())

                Text(name)
                    .font(.title2)
                Text(title)
                    .foregroundColor(.secondary)
            }
        }
    }
}

extension StateManagement {
    struct CounterView: View {
        // Source of truth using @State
        @State private var count = 0

        var body: some View {
            VStack {
                Text("Count: \(count)")
                Button("Increment") {
                    count += 1
                }
            }
        }
    }
}

extension StateManagement {
    // Parent View
    struct SettingsView: View {
        @State private var isNotificationsEnabled = false

        var body: some View {
            VStack {
                Text("Settings")
                    .font(.title)

                NotificationToggle(isEnabled: $isNotificationsEnabled)

                Text("Notifications are \(isNotificationsEnabled ? "enabled" : "disabled")")
            }
        }
    }
    // Child View with Binding
    struct NotificationToggle: View {
        @Binding var isEnabled: Bool

        var body: some View {
            Toggle("Enable Notifications", isOn: $isEnabled)
                .padding()
        }
    }
}

extension StateManagement {
    @Observable
    class UserProfile {
        var name: String
        var email: String

        init(name: String, email: String) {
            self.name = name
            self.email = email
        }
    }
    struct ProfileView: View {
        @State private var profile = UserProfile(name: "John", email: "john@example.com")

        var body: some View {
            Form {
                TextField("Name", text: $profile.name)
                TextField("Email", text: $profile.email)

                Text("Current name: \(profile.name)")
                Text("Current email: \(profile.email)")
            }
        }
    }
}

// Define environment key
private struct ThemeKey: EnvironmentKey {
    static let defaultValue = Theme.light
}

// Usage in views
struct ThemeAwareView: View {
    @Environment(\.theme) var theme

    var body: some View {
        Text("Themed Content")
            .foregroundColor(theme == .light ? .black : .white)
            .background(theme == .light ? .white : .black)
    }
}
enum Theme {
    case light, dark
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

#Preview("Contact Header Example") {
    StateManagement.ContactHeader(
        photo: Image(systemName: "person.circle.fill"),
        name: "John Doe",
        title: "iOS Developer"
    )
}

#Preview("Basic Counter with State") {
    StateManagement.CounterView()
}

#Preview("Settings with Bindings") {
    StateManagement.SettingsView()
}

#Preview("Observable Profile Form") {
    StateManagement.ProfileView()
}

#Preview("Theme Aware Content") {
    VStack {
        ThemeAwareView()
            .environment(\.theme, .light)
        ThemeAwareView()
            .environment(\.theme, .dark)
    }
}