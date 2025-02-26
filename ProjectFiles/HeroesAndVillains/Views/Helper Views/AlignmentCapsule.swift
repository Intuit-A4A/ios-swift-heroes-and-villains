import SwiftUI

typealias HeroAlignment = Biography.Alignment

/// A specialized view presenting a hero's alignment
/// - Parameter alignment: The `HeroAlignment` of a character
struct AlignmentCapsule: View {
    
    let alignment: HeroAlignment
    
    var body: some View {
        
        Text((alignment.rawValue.capitalized))
            .font(.caption)
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
            .foregroundStyle(Color(alignment == .bad ? .yellow : .white))
            .background {
                Color(alignment == .good ? .green : alignment == .bad ? .red : .gray)
                .clipShape(Capsule()) }
    }
}


// MARK: - Previews
#Preview {
    VStack(spacing: 0) {
        Spacer()
        
        Text("Some Good Guy").font(.largeTitle)
        AlignmentCapsule(alignment: .good)
        
        Spacer()
        
        Text("Some Bad Guy").font(.largeTitle)
        AlignmentCapsule(alignment: .bad)
        
        Spacer()
        
        Text("Other").font(.largeTitle)
        AlignmentCapsule(alignment: .other)
        
        Spacer()
    }
}
