import SwiftUI

@main
struct PolApexApp: App {
    @StateObject private var progress = ProgressManager.shared
    @StateObject private var appearance = AppearanceManager.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(progress)
                .preferredColorScheme(appearance.colorScheme)
        }
    }
}
