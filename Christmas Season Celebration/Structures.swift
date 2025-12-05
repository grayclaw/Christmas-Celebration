//
//  Structures.swift
//  Christmas Celebration
//
//  Created by Brian Homer Jr on 11/26/25.
//

import Foundation

struct ScriptureReference: Codable, Identifiable {
    var id = UUID()
    let reference: String          // "Matthew 27:50–54"
    let textVariable: String       // e.g. "matt_27_50_54"
    let link: URL?
}

struct TalkReference: Codable, Identifiable {
    var id = UUID()
    let title: String
    let link: URL?
}

struct DailyContent: Identifiable, Codable {
    var id = UUID()
    let scripture: ScriptureReference
    let talk: TalkReference
}

enum DevotionalSeason: String, Codable {
    case easter
    case christmas
}

struct SeasonalSuggestions {
    let season: DevotionalSeason
    let content: [DailyContent]
}

