import SwiftUI

struct HeroDetail: View {
    let hero: Hero
    
    var body: some View {
        
        ZStack {
            HeroDetailBackground(url: hero.images.small)

            VStack(spacing: 0) {
                Text(hero.name).font(.largeTitle)
                
                AlignmentCapsule(alignment: hero.biography.alignment)
                
                Spacer()
            }
        }
    }
}


// MARK: - Previews
#Preview { HeroDetail(hero: HeroViewModel.sample.heroes.first!) }
