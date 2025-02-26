import SwiftUI

/// A background containing a hero image, typically used for Detail views.
/// - Parameter url: The `URL` of the image to be drawn

struct HeroDetailBackground: View {
    @Environment(\.colorScheme) var colorScheme

    let url: URL

    var body: some View {
        ZStack {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 5)
            } placeholder: { /* intentionally blank */ }

            let color = colorScheme == .dark ? Color.black : .white
            color.opacity(0.5)
                .ignoresSafeArea()
        }
    }
}


// MARK: - Previews
private let heroes = HeroViewModel.sample.heroes

#Preview { HeroDetailBackground(url: heroes[1].images.small) }
#Preview { HeroDetailBackground(url: heroes[4].images.small) }
