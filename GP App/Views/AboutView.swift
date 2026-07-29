import SwiftUI

struct AboutView: View {
    @AppStorage("appearance") private var appearance = Appearance.system.rawValue

    var body: some View {
        List {
            Section {
                VStack(spacing: 14) {
                    Image("AppIconPreview").resizable().scaledToFit().frame(width: 96, height: 96).clipShape(RoundedRectangle(cornerRadius: 22))
                    Text("Ghent Photography").font(.title2.bold())
                    Text("Discovering Ghent, one frame at a time.").foregroundStyle(.secondary)
                }.frame(maxWidth: .infinity).multilineTextAlignment(.center).padding(.vertical)
                .accessibilityElement(children: .combine)
            }
            Section("Appearance") {
                Picker("Color scheme", selection: $appearance) { ForEach(Appearance.allCases) { Text($0.title).tag($0.rawValue) } }
            }
            Section("Our story") {
                Text("Ghent Photography celebrates the architecture, streets and quiet details of Ghent through a local photographer’s lens.")
                Text("The Vault is an app-exclusive archive: a place for experiments, overlooked moments and personal favourites.")
            }
            Section("Privacy") {
                Label("Your viewing stays on your device", systemImage: "hand.raised.fill")
                Text("GP App does not require an account, track your activity or send push notifications.").foregroundStyle(.secondary)
            }
            Section {
                Link(destination: URL(string: "https://ghentphotography.be")!) { Label("Visit Ghent Photography", systemImage: "safari") }
                Link(destination: URL(string: "mailto:info@ghentphotography.be")!) { Label("Get in touch", systemImage: "envelope") }
            }
            Section { Text(versionText).foregroundStyle(.secondary) }
        }
        .navigationTitle("About")
        .toolbarBackground(Color.accentColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var versionText: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "—"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "—"
        return "GP App \(version) (\(build))\n© Dave Van Cauwenberghe"
    }
}
