import Foundation


// MARK: - Decodable Structs
struct Hero: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let images: Images
    var relatives: [String] { connections.relatives }
    var occupation: String? { work.occupation }
    
    private let work: Work
    private let connections: Connections
}

struct Appearance: Decodable, Hashable {
    let gender: Gender?
    let race: Race?
    let height: String?
    let weight: String?
    let eyeColor: Color?
    let hairColor: Color?
}

struct Biography: Decodable, Hashable {
    let fullName: String
    let aliases: [String]
    let placeOfBirth: String?
    let alignment: Alignment
}

struct Images: Decodable, Hashable {
    let thumbnail: URL
    let small: URL
    let large: URL
}

/// A set of `Int` values ranging from 0 ... 100
struct Powerstats: Decodable, Hashable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let power: Int
}

private struct Connections: Decodable, Hashable {
    let relatives: [String]
}

private struct Work: Decodable, Hashable {
    let occupation: String?
}



// MARK: - Coding Keys and Helpers
extension Hero: Equatable {
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        lhs.id == rhs.id
    }
}

/* NOTE: 
    Because source API data unfortunately uses hyphens to indicate unknown or missing values,
    we leverage `fauxNilString` below to catch these and return true `nil` values when appropriate.
 */

fileprivate let fauxNilString = "-"

extension Appearance {
    enum CodingKeys: String, CodingKey {
        case gender
        case race
        case height
        case weight
        case color
    }
    
    enum Gender: String, Decodable {
        case male   = "Male"
        case female = "Female"
    }
    
    enum Race: String, Decodable {
        case human    = "Human"
        case cyborg   = "Cyborg"
        case android  = "Android"
        case mutant   = "Mutant"
        case god      = "God / Eternal"
        case symbiote = "Symbiote"
        case alien    = "Alien"
        case demon    = "Demon"
    }
    
    enum Color: String, Decodable {
        case amber   = "Amber"
        case auburn  = "Auburn"
        case black   = "Black"
        case blond   = "Blond"
        case blue    = "Blue"
        case brown   = "Brown"
        case gold    = "Gold"
        case green   = "Green"
        case grey    = "Grey"
        case hazel   = "Hazel"
        case indigo  = "Indigo"
        case magenta = "Magenta"
        case orange  = "Orange"
        case pink    = "Pink"
        case purple  = "Purple"
        case red     = "Red"
        case silver  = "Silver"
        case violet  = "Violet"
        case white   = "White"
        case yellow  = "Yellow"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gender = try? container.decode(Gender.self, forKey: .gender)
        race = try? container.decode(Race.self, forKey: .race)
        eyeColor = try? container.decode(Color.self, forKey: .color)
        hairColor = try? container.decode(Color.self, forKey: .color)

        var heightContainer = try container.nestedUnkeyedContainer(forKey: .height)
        if let rawHeight = try? heightContainer.decode(String.self) {
            height = rawHeight + "\""
        } else {
            height = nil
        }
        
        var weightContainer = try container.nestedUnkeyedContainer(forKey: .weight)
        if let rawWeight = try? weightContainer.decode(String.self), let intWeight = Int(rawWeight) {
            weight = "\(intWeight) lbs"
        } else {
            weight = nil
        }
    }
}


extension Biography {
    enum CodingKeys: String, CodingKey {
        case fullName
        case aliases
        case placeOfBirth
        case alignment
    }
    
    enum Alignment: String, Decodable {
        case good
        case bad
        case other
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try container.decode(String.self, forKey: .fullName)
        
        if let rawAlignment = try? container.decode(Alignment.self, forKey: .alignment) {
            alignment = rawAlignment
        } else {
            alignment = .other
        }
        
        if let rawAliases = try? container.decode([String].self, forKey: .aliases) {
            aliases = rawAliases.filter { $0 != fauxNilString}
        } else {
            aliases = []
        }
        
        if let rawPlaceOfBirth = try? container.decode(String.self, forKey: .placeOfBirth), rawPlaceOfBirth != fauxNilString {
            placeOfBirth = rawPlaceOfBirth
        } else {
            placeOfBirth = nil
        }
    }
}


extension Connections {
    enum CodingKeys: String, CodingKey {
        case relatives
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let relativesString = try? container.decode(String.self, forKey: .relatives) {
            relatives = relativesString.components(separatedBy: "; ")
                .filter { $0 != fauxNilString }
        } else {
            relatives = []
        }
    }
}


extension Images {
    enum CodingKeys: String, CodingKey {
        case xs
        case sm
        case lg
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail = URL(string: try container.decode(String.self, forKey: .xs))!
        small = URL(string: try container.decode(String.self, forKey: .sm))!
        large = URL(string: try container.decode(String.self, forKey: .lg))!
    }
}

extension Work {
    enum CodingKeys: String, CodingKey {
        case occupation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let rawOccupation = try? container.decode(String.self, forKey: .occupation), rawOccupation != fauxNilString {
            occupation = rawOccupation
        } else {
            occupation = nil
        }
    }
}
