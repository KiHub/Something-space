//
//  Photo.swift
//  Something space
//
//  Created by  Mr.Ki on 25.10.2022.
//

import Foundation

struct Photo: Codable, Identifiable {
    var title: String
    var description: String
    var url: URL?
    var copyright: String?
    var date: String
    
    let id = UUID()
    
    var formatterDate: Date {
        let dateFormatter = API.createFormatter()
        return dateFormatter.date(from: self.date) ?? Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
        case date = "date"
    }
    
    init (from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    
    init() {
        self.description = ""
        self.title = ""
        self.date = ""
    }
    
    static func createDefault() -> Photo {
        var photo = Photo()
        photo.title = "Cocoon Nebula Wide Field"
        photo.description = "When does a nebula look like a comet?  In this crowded starfield, covering over two degrees within the high flying constellation of the Swan (Cygnus), the eye is drawn to the Cocoon Nebula. A compact star forming region, the cosmic Cocoon punctuates a nebula bright in emission and reflection on the left, with a long trail of interstellar dust clouds to the right, making the entire complex appear a bit like a comet. Cataloged as IC 5146, the central bright head of the nebula spans about 10 light years, while the dark dusty tail spans nearly 100 light years.  Both are located about 2,500 light years away. The bright star near the bright nebula's center, likely only a few hundred thousand years old, supplies power to the nebular glow as it helps clear out a cavity in the molecular cloud's star forming dust and gas. The long dusty filaments of the tail, although dark in this visible light image, are themselves hiding stars in the process of formation, stars that can be seen at infrared wavelengths."
        photo.date = "2022-10-26"
        return photo
    }
    
}
