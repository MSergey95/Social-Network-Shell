import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView(currentFolderURL: FileManagerService.shared.documentsURL, folderTitle: "Documents")
                .tabItem {
                    Label("Files", systemImage: "folder")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
