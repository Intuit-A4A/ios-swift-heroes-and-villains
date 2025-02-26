import SwiftUI

struct ContentView: View {
    @State private var selectedHero: Hero?
    
    let viewModel = HeroViewModel()
    
    var body: some View {
        
        NavigationSplitView {
            
            Heroes(selectedHero: $selectedHero)
                .navigationTitle("Heroes & Villains")
            
        } detail: {
            
            if let hero = selectedHero {
                HeroDetail(hero: hero)
            } else {
                VStack {
                    Text("Please select a Hero or Villain…").font(.title).foregroundStyle(Color.secondary)
                    Spacer()
                }
            }
        }
        .environmentObject(viewModel)
        .task(priority: .userInitiated) { viewModel.getHeroes() }
    }
}


// MARK: - Previews
#Preview { ContentView() }
