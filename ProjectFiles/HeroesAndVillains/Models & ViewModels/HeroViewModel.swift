import Foundation
import Combine

class HeroViewModel: ObservableObject {
    @Published var heroes = [Hero]()
    
    func getHeroes() {
        let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json")!
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let data else {
                print("Could not fetch data: \(String(describing: error))")
                return
            }

            do {
                let decodedHeroes = try JSONDecoder().decode([Hero].self, from: data)
                
                DispatchQueue.main.async {
                    if let self { self.heroes = decodedHeroes }
                }
                
            } catch {
                print("Could not decode data: \(String(describing: error))")
            }
            
        }.resume()
    }
    
    
    /// Provides an array of 5 sample `Hero` items for SwiftUI previews, tests, etc.
    static var sample: HeroViewModel = {
        let json = """
        [{"id":1,"name":"A-Bomb","slug":"1-a-bomb","powerstats":{"intelligence":38,"strength":100,"speed":17,"durability":80,"power":24,"combat":64},"appearance":{"gender":"Male","race":"Human","height":["6'8","203 cm"],"weight":["980 lb","441 kg"],"eyeColor":"Yellow","hairColor":"No Hair"},"biography":{"fullName":"Richard Milhouse Jones","alterEgos":"No alter egos found.","aliases":["Rick Jones"],"placeOfBirth":"Scarsdale, Arizona","firstAppearance":"Hulk Vol 2 #2 (April, 2008) (as A-Bomb)","publisher":"Marvel Comics","alignment":"good"},"work":{"occupation":"Musician, adventurer, author; formerly talk show host","base":"-"},"connections":{"groupAffiliation":"Hulk Family; Excelsior (sponsor), Avengers (honorary member); formerly partner of the Hulk, Captain America and Captain Marvel; Teen Brigade; ally of Rom","relatives":"Marlo Chandler-Jones (wife); Polly (aunt); Mrs. Chandler (mother-in-law); Keith Chandler, Ray Chandler, three unidentified others (brothers-in-law); unidentified father (deceased); Jackie Shorr (alleged mother; unconfirmed)"},"images":{"xs":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/xs/1-a-bomb.jpg","sm":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/sm/1-a-bomb.jpg","md":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/md/1-a-bomb.jpg","lg":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/1-a-bomb.jpg"}},{"id":2,"name":"Abe Sapien","slug":"2-abe-sapien","powerstats":{"intelligence":88,"strength":28,"speed":35,"durability":65,"power":100,"combat":85},"appearance":{"gender":"Male","race":"Icthyo Sapien","height":["6'3","191 cm"],"weight":["145 lb","65 kg"],"eyeColor":"Blue","hairColor":"No Hair"},"biography":{"fullName":"Abraham Sapien","alterEgos":"No alter egos found.","aliases":["Langdon Everett Caul","Abraham Sapien","Langdon Caul"],"placeOfBirth":"-","firstAppearance":"Hellboy: Seed of Destruction (1993)","publisher":"Dark Horse Comics","alignment":"good"},"work":{"occupation":"Paranormal Investigator","base":"-"},"connections":{"groupAffiliation":"Bureau for Paranormal Research and Defense","relatives":"Edith Howard (wife, deceased)"},"images":{"xs":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/xs/2-abe-sapien.jpg","sm":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/sm/2-abe-sapien.jpg","md":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/md/2-abe-sapien.jpg","lg":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/2-abe-sapien.jpg"}},{"id":3,"name":"Abin Sur","slug":"3-abin-sur","powerstats":{"intelligence":50,"strength":90,"speed":53,"durability":64,"power":99,"combat":65},"appearance":{"gender":"Male","race":"Ungaran","height":["6'1","185 cm"],"weight":["200 lb","90 kg"],"eyeColor":"Blue","hairColor":"No Hair"},"biography":{"fullName":"","alterEgos":"No alter egos found.","aliases":["Lagzia"],"placeOfBirth":"Ungara","firstAppearance":"Showcase #22 (October, 1959)","publisher":"DC Comics","alignment":"good"},"work":{"occupation":"Green Lantern, former history professor","base":"Oa"},"connections":{"groupAffiliation":"Green Lantern Corps, Black Lantern Corps","relatives":"Amon Sur (son), Arin Sur (sister), Thaal Sinestro (brother-in-law), Soranik Natu (niece)"},"images":{"xs":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/xs/3-abin-sur.jpg","sm":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/sm/3-abin-sur.jpg","md":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/md/3-abin-sur.jpg","lg":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/3-abin-sur.jpg"}},{"id":4,"name":"Abomination","slug":"4-abomination","powerstats":{"intelligence":63,"strength":80,"speed":53,"durability":90,"power":62,"combat":95},"appearance":{"gender":"Male","race":"Human / Radiation","height":["6'8","203 cm"],"weight":["980 lb","441 kg"],"eyeColor":"Green","hairColor":"No Hair"},"biography":{"fullName":"Emil Blonsky","alterEgos":"No alter egos found.","aliases":["Agent R-7","Ravager of Worlds"],"placeOfBirth":"Zagreb, Yugoslavia","firstAppearance":"Tales to Astonish #90","publisher":"Marvel Comics","alignment":"bad"},"work":{"occupation":"Ex-Spy","base":"Mobile"},"connections":{"groupAffiliation":"former member of the crew of the Andromeda Starship, ally of the Abominations and Forgotten","relatives":"Nadia Dornova Blonsky (wife, separated)"},"images":{"xs":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/xs/4-abomination.jpg","sm":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/sm/4-abomination.jpg","md":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/md/4-abomination.jpg","lg":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/4-abomination.jpg"}},{"id":5,"name":"Abraxas","slug":"5-abraxas","powerstats":{"intelligence":88,"strength":63,"speed":83,"durability":100,"power":100,"combat":55},"appearance":{"gender":"Male","race":"Cosmic Entity","height":["-","0 cm"],"weight":["- lb","0 kg"],"eyeColor":"Blue","hairColor":"Black"},"biography":{"fullName":"Abraxas","alterEgos":"No alter egos found.","aliases":["-"],"placeOfBirth":"Within Eternity","firstAppearance":"Fantastic Four Annual #2001","publisher":"Marvel Comics","alignment":"bad"},"work":{"occupation":"Dimensional destroyer","base":"-"},"connections":{"groupAffiliation":"Cosmic Beings","relatives":"Eternity (Father)"},"images":{"xs":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/xs/5-abraxas.jpg","sm":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/sm/5-abraxas.jpg","md":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/md/5-abraxas.jpg","lg":"https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/5-abraxas.jpg"}}]
        """.data(using: .utf8)!
                
        let exampleViewModel = HeroViewModel()
        exampleViewModel.heroes = try! JSONDecoder().decode([Hero].self, from: json)
        
        return exampleViewModel
    }()
}
