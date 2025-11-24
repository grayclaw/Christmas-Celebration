//
//  Daily_Suggestions.swift
//  The Season of Christ
//
//  Created by Brian Homer Jr on 11/19/25.
//

import Foundation

struct DailySuggestion: Identifiable {
    let id = UUID()
    let day: Int
    let date: Date
    let scripture: String
    let scriptureLink: URL?
    let talkTitle: String
    let talkLink: URL?
    let suggestion: String
    let suggestionLink: URL?
    
    static func today() -> DailySuggestion? {
        let calendar = Calendar.current
        let today = Date()
        
        return allSuggestions.first { suggestion in
            calendar.isDate(suggestion.date, inSameDayAs: today)
        }
    }
    
    static let allSuggestions: [DailySuggestion] = [
        DailySuggestion(
            day: 1,
            date: DateComponents(calendar: .current, year: 2025, month: 11, day: 25).date!,
            scripture: "1 Nephi 11:13–23",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/1-ne/11?lang=eng&id=p13-p23#p13"),
            talkTitle: "Glad Tidings of Love and Joy",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/liahona/2025/01/04-glad-tidings-of-love-and-joy"),
            suggestion: "Visit someone who is lonely.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 2,
            date: DateComponents(calendar: .current, year: 2025, month: 11, day: 26).date!,
            scripture: "Isaiah 7:14",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/ot/isa/7?lang=eng&id=p14#p14"),
            talkTitle: "Drawing the Power of Jesus Christ into Our Lives",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2017/04/drawing-the-power-of-jesus-christ-into-our-lives"),
            suggestion: "Ask to be forgiven and settle a grudge or past issue.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 3,
            date: DateComponents(calendar: .current, year: 2025, month: 11, day: 27).date!,
            scripture: "Isaiah 53:3–5, 7–9",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/ot/isa/53?lang=eng&id=p3-p5,p7-p9#p3"),
            talkTitle: "Glad Tidings of Great Joy: The Birth of Jesus Christ",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/ensign/2010/12/glad-tidings-of-great-joy"),
            suggestion: "Send a note of gratitude.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 4,
            date: DateComponents(calendar: .current, year: 2025, month: 11, day: 28).date!,
            scripture: "Joseph Smith — History 1:14–20",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/pgp/js-h/1?lang=eng&id=p14-p20#p14"),
            talkTitle: "Why We Need a Savior",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2015-12-1000-why-we-need-a-savior?lang=eng"),
            suggestion: "Spend time in prayer to seek for peace in your heart and the world.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 5,
            date: DateComponents(calendar: .current, year: 2025, month: 11, day: 29).date!,
            scripture: "Helaman 16:1-23",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/hel/16?lang=eng&id=p1-p23#p1"),
            talkTitle: "Prophetic Announcements of Christ's Birth",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/broadcasts/first-presidency-christmas-devotional/2016/12/prophetic-announcements-of-christs-birth?lang=eng"),
            suggestion: "Call someone you miss.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 6,
            date: DateComponents(calendar: .current, year: 2025, month: 11, day: 30).date!,
            scripture: "Luke 1",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/luke/1?lang=eng&#p1"),
            talkTitle: "The Living Christ",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/manual/the-living-christ-the-testimony-of-the-apostles/the-living-christ-the-testimony-of-the-apostles"),
            suggestion: "Read and ponder 'The Living Christ.'",
            suggestionLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/the-living-christ-the-testimony-of-the-apostles/the-living-christ-the-testimony-of-the-apostles?lang=eng")
        ),
        DailySuggestion(
            day: 7,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 1).date!,
            scripture: "2 Nephi 2:6–8",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/2-ne/2?lang=eng&id=p6-p8#p6"),
            talkTitle: "The Living Christ: The Heart of Restoration – Elder Uchtdorf",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2021/10/11uchtdorf"),
            suggestion: "Write a short testimony of Jesus Christ.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 8,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 2).date!,
            scripture: "Matthew 1",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/matt/1?lang=eng&#p1"),
            talkTitle: "The Christ Child (trailer)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2019-09-0050-the-christ-child-a-nativity-story-lighttheworld"),
            suggestion: "Watch the trailer and invite a friend to watch the full film later.",
            suggestionLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2019-09-0050-the-christ-child-a-nativity-story-lighttheworld"),
        ),
        DailySuggestion(
            day: 9,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 3).date!,
            scripture: "Mosiah 3:5–8",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/mosiah/3?lang=eng&id=p5-p8#p5"),
            talkTitle: "The Living Bread Which Came Down from Heaven – Elder Christofferson",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2017/10/the-living-bread-which-came-down-from-heaven"),
            suggestion: "Bake bread and share it with someone in need.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 10,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 4).date!,
            scripture: "Isaiah 9:6",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/ot/isa/9?lang=eng&id=p6#p6"),
            talkTitle: "A Savior Is Born (video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2015-12-1000-a-savior-is-born"),
            suggestion: "Share the video on social media.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 11,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 5).date!,
            scripture: "Alma 7:10–12",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/alma/7?lang=eng&id=p10-p12#p10"),
            talkTitle: "The Character of Christ – Elder Bednar",
            talkLink: URL(string: "https://speeches.byu.edu/talks/david-a-bednar/character-christ/"),
            suggestion: "Serve someone quietly today.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 12,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 6).date!,
            scripture: "Doctrine and Covenants 93:11-17",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/dc-testament/dc/93?lang=eng&id=p11-p17#p11"),
            talkTitle: "Mary, the Mother of Jesus (Bible Video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2011-03-0100-mary-is-visited-by-angel-gabriel"),
            suggestion: "Reflect on Mary’s faith and courage.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 13,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 7).date!,
            scripture: "3 Nephi 11:10–11",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/3-ne/11?lang=eng&id=p10-p11#p10"),
            talkTitle: "He Is Risen (video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2019-04-0100-he-is-risen"),
            suggestion: "Write a thank-you note to the Savior.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 14,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 8).date!,
            scripture: "John 1:1–5",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/john/1?lang=eng&id=p1-p5#p1"),
            talkTitle: "The Light That Shineth in Darkness – Elder Kearon",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2022/10/14kearon"),
            suggestion: "Light a candle and ponder Christ’s light.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 15,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 9).date!,
            scripture: "Helaman 14:1–9",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/hel/14?lang=eng&id=p1-p9#p1"),
            talkTitle: "Samuel and the Star (Book of Mormon Video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2019-11-1100-samuel-and-the-star"),
            suggestion: "Look at the stars and reflect on signs of Christ.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 16,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 10).date!,
            scripture: "1 Nephi 10:4",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/1-ne/10?lang=eng&id=p4#p4"),
            talkTitle: "The Nativity (Bible Video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2011-12-0100-the-nativity"),
            suggestion: "Set up a nativity scene in your home.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 17,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 11).date!,
            scripture: "Mosiah 15:1–9, 11",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/mosiah/15?lang=eng&id=p1-p9,p11#p1"),
            talkTitle: "The Infinite Power of Hope – President Uchtdorf",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2008/10/the-infinite-power-of-hope"),
            suggestion: "Share a hopeful message with someone discouraged.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 18,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 12).date!,
            scripture: "Matthew 2",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/matt/2?lang=eng&#p1"),
            talkTitle: "Wise Men Still Seek Him (video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2011-12-0101-wise-men-still-seek-him"),
            suggestion: "Write down how you seek Christ daily.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 19,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 13).date!,
            scripture: "2 Nephi 25:19, 26",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/2-ne/25?lang=eng&id=p19,p26#p19"),
            talkTitle: "We Talk of Christ – Elder Christofferson",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2020/10/13christofferson"),
            suggestion: "Share your favorite scripture about Christ.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 20,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 14).date!,
            scripture: "John 3:16–17",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/john/3?lang=eng&id=p16-p17#p16"),
            talkTitle: "Because of Him (video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2014-04-1030-because-of-him"),
            suggestion: "Watch and share the video with a friend.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 21,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 15).date!,
            scripture: "Alma 5:14",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/alma/5?lang=eng&id=p14#p14"),
            talkTitle: "What Thinks Christ of Me? – Elder Andersen",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2012/04/what-thinks-christ-of-me"),
            suggestion: "Journal your answer to that question.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 22,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 16).date!,
            scripture: "Micah 5:2",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/ot/micah/5?lang=eng&id=p2#p2"),
            talkTitle: "Shepherds Learn of the Birth of Christ (Bible Video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2011-12-0102-shepherds-learn-of-the-birth-of-christ"),
            suggestion: "Sing or listen to 'Far, Far Away on Judea’s Plains.'",
            suggestionLink: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/2013-12-far-far-away-on-judeas-plains?lang=eng/")
        ),
        DailySuggestion(
            day: 23,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 17).date!,
            scripture: "3 Nephi 1:5–21",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/3-ne/1?lang=eng&id=p5-p21#p5"),
            talkTitle: "Signs of Christ’s Birth (Book of Mormon Video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2019-11-1200-signs-of-christs-birth"),
            suggestion: "Share a testimony of Christ’s birth.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 24,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 18).date!,
            scripture: "Matthew 5:14–16",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/matt/5?lang=eng&id=p14-p16#p14"),
            talkTitle: "Be a Light – President Nelson",
            talkLink: URL(string: "https://www.instagram.com/p/CI0vZk7nq5v/"),
            suggestion: "Do a secret act of service.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 25,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 19).date!,
            scripture: "Mosiah 2:17",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/mosiah/2?lang=eng&id=p17#p17"),
            talkTitle: "Lift Where You Stand – Elder Uchtdorf",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2008/10/lift-where-you-stand"),
            suggestion: "Help someone in your family or ward.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 26,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 20).date!,
            scripture: "John 20:1-31",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/john/20?lang=eng&id=p1-p31#p1"),
            talkTitle: "Mary’s Song (Bible Video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2011-12-0103-marys-song"),
            suggestion: "Write your own song or poem of praise.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 27,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 21).date!,
            scripture: "Ether 3:6–16",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/ether/3?lang=eng&id=p6-p16#p6"),
            talkTitle: "The Light of the Perfect Leader – President Monson",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2005/10/the-light-of-the-perfect-leader"),
            suggestion: "Reflect on how Christ leads you.",
            suggestionLink: nil
        ),
        DailySuggestion(
            day: 28,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 22).date!,
            scripture: "Matthew 25:40",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/matt/25?lang=eng&id=p40#p40"),
            talkTitle: "Light the World (video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/comeuntochrist/light-the-world"),
            suggestion: "Choose a Light the World act of kindness.",
            suggestionLink: URL(string: "https://www.churchofjesuschrist.org/comeuntochrist/light-the-world"),
        ),
        DailySuggestion(
            day: 29,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 23).date!,
            scripture: "Luke 2",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/luke/2?lang=eng&#p1"),
            talkTitle: "The Christ Child (Full Nativity Video)",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2019-09-0050-the-christ-child-a-nativity-story-lighttheworld"),
            suggestion: "Watch the full video with family or friends.",
            suggestionLink: URL(string: "https://www.churchofjesuschrist.org/media/video/2019-09-0050-the-christ-child-a-nativity-story-lighttheworld"),
        ),
        DailySuggestion(
            day: 30,
            date: DateComponents(calendar: .current, year: 2025, month: 12, day: 24).date!,
            scripture: "John 14:27",
            scriptureLink: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/john/14?lang=eng&id=p27#p27"),
            talkTitle: "Peace in Christ – Music Video",
            talkLink: URL(string: "https://www.churchofjesuschrist.org/media/music/video/2018-01-0001-peace-in-christ"),
            suggestion: "Spend quiet time reflecting on the Savior’s peace and love.",
            suggestionLink: nil
        )
    ]
}
