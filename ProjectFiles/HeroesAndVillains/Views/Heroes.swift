import SwiftUI

struct Heroes: View {
    
    @EnvironmentObject var viewModel: HeroViewModel
    @Binding var selectedHero: Hero?
    @State private var searchText = ""
    
    var body: some View {
        
        List(viewModel.heroes.filter({ $0.items(matching: searchText) }), selection: $selectedHero) { hero in
            NavigationLink(value: hero) {
                HStack {
                    HeroStarImage(url: hero.images.small)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(hero.name).font(.title)
                        AlignmentCapsule(alignment: hero.biography.alignment)
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 100)
            .padding(.leading, 15)
        }
        .searchable(text: $searchText)
    }
}


// MARK: - Previews
private let sampleViewModel = HeroViewModel.sample

#Preview {
    Heroes(selectedHero: .constant(sampleViewModel.heroes.first!))
        .environmentObject(sampleViewModel)
}


// MARK: - Hero Extensions
extension Hero {
    
    func items(matching searchText: String) -> Bool {
        searchText.trimmingCharacters(in: .whitespaces).isEmpty ||
        name.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))
    }
}
