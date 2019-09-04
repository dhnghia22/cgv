//
//  Mock.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo


extension Banner: MockAble {
    static func mock() -> Banner {
        return Banner(type: "Test",
                      url: String.random(),
                      id: String.random(),
                      image: String.random())
    }
}

//extension SneakShow: MockAble {
//    static func mock() -> SneakShow {
//        return SneakShow(id: "Test",
//                         sku: String.random(),
//                         categoryID: Int.random(),
//                         category: String.random(), name: String.random(), thumbnail: String.random(), movieTrailer: String.random(), movieEvent: String.random(), ratingCode: String.random(), ratingIcon: String.random(), codes: String.random(), isBooking: Bool.random(), isSneakshow: Bool.random(), isNew: Bool.random(), position: Int.random(), movieEndtime: Int.random(), releaseDate: String.random(), isGerp: Bool.random())
//    }
//}

extension Special: MockAble {
    static func mock() -> Special {
        return Special(title: String.random(), id: Int.random(), code: String.random(), smallImage: String.random(), mainImage: String.random())
    }
}

extension Cinema: MockAble {
    static func mock() -> Cinema {
        return Cinema(id: String.random(), code: String.random(), name: String.random(), thumbnail: String.random(), latitude: String.random(), longitude: String.random(), address: String.random(), isGerp: Bool.random(), images: [String.random()], specials: [Special.mock()])
    }
}

extension CinemaRegion: MockAble {
    static func mock() -> CinemaRegion {
        return CinemaRegion(name: String.random(), cinemas: [Cinema.mock()])
    }
}

extension Blog: MockAble {
    static func mock() -> Blog {
        return Blog(id: String.random(), title: String.random(), thumbnail: String.random(), content: String.random(), shortDescription: String.random(), url: String.random(), images: [String.random()])
    }
}

extension Movie: MockAble {
    static func mock() -> Movie {
        return Movie(id: String.random(), sku: String.random(), category: String.random(), name: String.random(), thumbnail: String.random(), url: String.random(), fullDescription: String.random(), genre: String.random(), ratingCode: String.random(), ratingIcon: String.random(), reviewPercent: String.random(), codes: String.random(), releaseDate: String.random(), movieTrailer: String.random(), movieDirector: String.random(), movieLanguage: String.random(), movieEndtime: Int.random(), movieActress: String.random(), isBooking: Bool.random(), isSneakshow: Bool.random(), isNew: Bool.random(), isGerp: Bool.random(), categoryID: Int.random(), movieEvent: String.random(), position: Int.random())
        
    }
}

extension Session: MockAble {
    static func mock() -> Session {
        return Session(id: Int.random(), cinemaID: String.random(), time: String.random(), room: String.random(), theater: String.random(), isBooking: Bool.random(), code: String.random(), remainingSeats: Int.random(), subType: String.random(), showingDateTime: String.random(), showingType: String.random())
    }
}

extension Language: MockAble {
    static func mock() -> Language {
        return Language(name: String.random(), nameColor: String.random(), code: String.random(), sessions: [Session.mock()])
    }
}

extension ShowTimeCinema: MockAble {
    static func mock() -> ShowTimeCinema {
        return ShowTimeCinema(id: String.random(), name: String.random(), latitude: String.random(), longitude: String.random(), languages: [Language.mock()])
    }
}

extension ShowTimeLocation: MockAble {
    static func mock() -> ShowTimeLocation {
        return ShowTimeLocation(name: String.random(), cinemas: [ShowTimeCinema.mock()])
    }
}

extension ShowTimeDate: MockAble {
    static func mock() -> ShowTimeDate {
        return ShowTimeDate(date: String.random(), locations: [ShowTimeLocation.mock()])
    }
}
