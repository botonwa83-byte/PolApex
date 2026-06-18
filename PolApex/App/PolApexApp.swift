import SwiftUI

@main
struct PolApexApp: App {
    @StateObject private var progress = ProgressManager.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(progress)
        }
    }
}
