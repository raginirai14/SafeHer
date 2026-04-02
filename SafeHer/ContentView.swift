import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            ContactsView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Contacts")
                }
                .tag(1)
            
            HistoryView()
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("History")
                }
                .tag(2)
            
            FakeCallView()
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Fake Call")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(4)
        }
        .accentColor(Color(hex: "FF2D55"))
    }
}

#Preview {
    ContentView()
}
