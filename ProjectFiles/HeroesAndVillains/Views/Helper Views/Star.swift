import SwiftUI

/// A Star shape centered on the current view
/// - Parameter points: The optional number of points the star should have (defaults to `5` if no value is provided)

struct Star: Shape {
    
    /// The number of points on the star
    let points: Int
    
    init(points: Int = 5) {
        self.points = points
    }
    
    /// Required method describing this shape as a path within a rectangular frame of reference.
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let distance = rect.width * 0.8
        let angleIncrement = .pi * 2 / CGFloat(points * 2)

        var starPath = Path()
        var lines: [CGPoint] = []
        var angle: CGFloat = -(.pi / 2)
        
        for _ in 0 ..< points {
            let pointA = pointFrom(angle: angle, distance: distance, offset: center)
            lines.append(pointA)
            angle += angleIncrement
            
            let pointB = pointFrom(angle: angle, distance: distance / 2, offset: center)
            lines.append(pointB)
            angle += angleIncrement
        }
        
        starPath.addLines(lines)
        starPath.closeSubpath()
        
        return starPath
    }
    
    func pointFrom(angle: CGFloat, distance: CGFloat, offset: CGPoint) -> CGPoint {
        
        let x = distance * cos(angle) + offset.x
        let y = distance * sin(angle) + offset.y
        
        return CGPoint(x: x, y: y)
    }
}


// MARK: - Previews
#Preview {
        VStack {
            Star(points: 3)
            Star()
            Star(points: 6)
            Star(points: 12)
        }
        .frame(width: 100)
}
