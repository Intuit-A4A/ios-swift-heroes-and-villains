import SwiftUI

/// An image of a hero, presented in a hybrid star/circle wrapper
/// - Parameter url: The `URL` containing the desired hero's image
struct HeroStarImage: View {
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { $0.resizable().scaledToFill() } placeholder: { ProgressView() }
            .clipShape(Star())
            .frame(width: 80)
            .shadow(color: .white, radius: 5)
            .background {
                Circle()
                    .fill(LinearGradient.hero)
                    .frame(width: 150, height: 150)
            }
    }
}


// MARK: - Previews

#Preview { HeroStarImage(url: HeroViewModel.sample.heroes[1].images.small) }


// MARK: - Private Extensions
private extension LinearGradient {
    static let hero = LinearGradient(
        gradient: Gradient(colors: [
            Color.purple.opacity(0.75),
            Color(hue: 0.33, saturation: 1, brightness: 0.9) // neon
                .opacity(0.1)
        ]),
        startPoint: .leading,
        endPoint: .center)
}
