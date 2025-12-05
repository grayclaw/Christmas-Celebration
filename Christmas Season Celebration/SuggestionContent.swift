//
//  SuggestionContent.swift
//  Christmas Celebration
//
//  Created by Brian Homer Jr on 12/5/25.
//
import Foundation

struct Suggestion {
    let title: String
    let link: URL?
}

enum SuggestionContent {
    static let data: [Suggestion] = [
        Suggestion(
            title: "Read and ponder 'The Living Christ.'",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/the-living-christ-the-testimony-of-the-apostles/the-living-christ-the-testimony-of-the-apostles?lang=eng")
        ),
        Suggestion(
            title: "Visit someone who might be lonely.",
            link: nil
        ),
        Suggestion(
            title: "Ask to be forgiven and settle a grudge or past issue.",
            link: nil
        ),
        Suggestion(
            title: "Send a note of gratitude.",
            link: nil
        ),
        Suggestion(
            title: "Spend time in prayer to seek for peace in your heart and the world.",
            link: nil
        ),
        Suggestion(
            title: "Call someone you miss.",
            link: nil
        ),
        Suggestion(
            title: "Read and ponder 'The Living Christ.'",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/the-living-christ-the-testimony-of-the-apostles/the-living-christ-the-testimony-of-the-apostles?lang=eng")
        ),
        Suggestion(
            title: "Write a short testimony of Jesus Christ.",
            link: nil
        ),
        Suggestion(
            title: "Bake bread and share it with someone in need.",
            link: nil
        ),
        Suggestion(
            title: "Serve someone quietly today.",
            link: nil
        ),
        Suggestion(
            title: "Reflect on Mary’s faith and courage.",
            link: nil
        ),
        Suggestion(
            title: "Write a thank-you note to the Savior.",
            link: nil
        ),
        Suggestion(
            title: "Ponder Christ’s light.",
            link: nil
        ),
        Suggestion(
            title: "Look at the stars and reflect on signs of Christ.",
            link: nil
        ),
        Suggestion(
            title: "Set up a nativity scene in your home.",
            link: nil
        ),
        Suggestion(
            title: "Share a hopeful message with someone discouraged.",
            link: nil
        ),
        Suggestion(
            title: "Write down how you seek Christ daily.",
            link: nil
        ),
        Suggestion(
            title: "Share your favorite scripture about Christ.",
            link: nil
        ),
        Suggestion(
            title: "Sing or listen to 'Far, Far Away on Judea’s Plains.'",
            link: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/2013-12-far-far-away-on-judeas-plains?lang=eng/")
        ),
        Suggestion(
            title: "Share a testimony of Christ’s birth.",
            link: nil
        ),
        Suggestion(
            title: "Do a secret act of service.",
            link: nil
        ),
        Suggestion(
            title: "Help someone in your family or ward.",
            link: nil
        ),
        Suggestion(
            title: "Write your own song or poem of praise.",
            link: nil
        ),
        Suggestion(
            title: "Reflect on how Christ leads you.",
            link: nil
        ),
        Suggestion(
            title: "Choose a Light the World act of kindness.",
            link: URL(string: "https://www.churchofjesuschrist.org/comeuntochrist/light-the-world"),
        ),
        Suggestion(
            title: "Spend quiet time reflecting on the Savior’s peace and love.",
            link: nil
        ),
        Suggestion(
            title: "Read the Sermon on the Mount and choose one teaching to apply.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/matt/5?lang=eng")
        ),
        Suggestion(
            title: "Fast and pray for someone in need.",
            link: nil
        ),
        Suggestion(
            title: "Study the parables of Jesus and share your favorite.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/manual/teachings-of-presidents-of-the-church-howard-w-hunter/chapter-17?lang=eng")
        ),
        Suggestion(
            title: "Forgive someone who has wronged you.",
            link: nil
        ),
        Suggestion(
            title: "Read 'The Family: A Proclamation to the World.'",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/the-family-a-proclamation-to-the-world/the-family-a-proclamation-to-the-world?lang=eng")
        ),
        Suggestion(
            title: "Donate to a charity or humanitarian cause.",
            link: nil
        ),
//        Suggestion(
//            title: "Watch 'The Christ Child' video.",
//            link: URL(string: "https://www.churchofjesuschrist.org/media/video/2012-12-1030-the-christ-child?lang=eng")
//        ),
        Suggestion(
            title: "Visit the temple or look at pictures of temples.",
            link: URL(string: "https://www.churchofjesuschrist.org/temples?lang=eng")
        ),
        Suggestion(
            title: "Memorize a favorite scripture about Christ.",
            link: nil
        ),
        Suggestion(
            title: "Share your testimony with a family member.",
            link: nil
        ),
        Suggestion(
            title: "Read about Christ's atoning sacrifice.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/manual/gospel-topics/atonement-of-jesus-christ?lang=eng")
        ),
        Suggestion(
            title: "Listen to 'I Believe in Christ.'",
            link: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/i-believe-in-christ?lang=eng")
        ),
        Suggestion(
            title: "Write in your journal about when you felt Christ's love.",
            link: nil
        ),
        Suggestion(
            title: "Prepare a meal for someone who is struggling.",
            link: nil
        ),
        Suggestion(
            title: "Study the life of Christ in the Book of Mormon.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/3-ne/11?lang=eng")
        ),
        Suggestion(
            title: "Invite someone to learn about Jesus Christ.",
            link: nil
        ),
        Suggestion(
            title: "Read President Nelson's teachings about the Savior.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/general-conference/2023/04/58nelson?lang=eng")
        ),
        Suggestion(
            title: "Give a sincere compliment to someone.",
            link: nil
        ),
        Suggestion(
            title: "Study Christ's miracles and ponder their meaning.",
            link: nil
        ),
        Suggestion(
            title: "Listen to 'O Holy Night.'",
            link: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/2016-12-o-holy-night?lang=eng")
        ),
        Suggestion(
            title: "Offer to help someone move or complete a task.",
            link: nil
        ),
        Suggestion(
            title: "Read the account of Christ's resurrection.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/luke/24?lang=eng")
        ),
        Suggestion(
            title: "Pray for your enemies or those who have hurt you.",
            link: nil
        ),
        Suggestion(
            title: "Study the names and titles of Jesus Christ.",
            link: URL(string: "https://www.churchofjesuschrist.org/comeuntochrist/believe/jesus/50-names-for-jesus")
        ),
        Suggestion(
            title: "Watch 'Lamb of God' video.",
            link: URL(string: "https://www.churchofjesuschrist.org/media/video/2019-03-0010-lamb-of-god?lang=eng")
        ),
        Suggestion(
            title: "Give an anonymous gift to someone.",
            link: nil
        ),
        Suggestion(
            title: "Read Alma 7:11-13 and ponder Christ's empathy.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/alma/7?lang=eng")
        ),
        Suggestion(
            title: "Attend church and partake of the sacrament.",
            link: nil
        ),
        Suggestion(
            title: "Study the Last Supper and its meaning.",
            link: nil
        ),
        Suggestion(
            title: "Sing or listen to 'I Stand All Amazed.'",
            link: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/i-stand-all-amazed?lang=eng")
        ),
        Suggestion(
            title: "Volunteer at a local service organization.",
            link: nil
        ),
        Suggestion(
            title: "Read Isaiah's prophecies about Christ.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/ot/isa/53?lang=eng")
        ),
        Suggestion(
            title: "Share a scripture on social media.",
            link: nil
        ),
        Suggestion(
            title: "Teach a child about Jesus Christ.",
            link: nil
        ),
        Suggestion(
            title: "Listen to 'Silent Night.'",
            link: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/silent-night?lang=eng")
        ),
        Suggestion(
            title: "Visit someone in a hospital or care facility.",
            link: nil
        ),
        Suggestion(
            title: "Read the Beatitudes and apply one today.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/matt/5.3-12?lang=eng")
        ),
        Suggestion(
            title: "Draw or color a picture of the Savior.",
            link: nil
        ),
        Suggestion(
            title: "Study Christ's interactions with children.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/3-ne/17?lang=eng")
        ),
        Suggestion(
            title: "Write a letter to someone who influenced your faith.",
            link: nil
        ),
        Suggestion(
            title: "Read about Christ in Gethsemane.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/luke/22.39-46?lang=eng")
        ),
        Suggestion(
            title: "Organize a family home evening about Christ.",
            link: nil
        ),
        Suggestion(
            title: "Listen to 'Come, Thou Fount of Every Blessing.'",
            link: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/come-thou-fount-of-every-blessing?lang=eng")
        ),
        Suggestion(
            title: "Study the Intercessory Prayer in John 17.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/john/17?lang=eng")
        ),
        Suggestion(
            title: "Bear your testimony in a meeting or gathering.",
            link: nil
        ),
        Suggestion(
            title: "Read about Christ's compassion for the multitudes.",
            link: nil
        ),
        Suggestion(
            title: "Create a playlist of Christ-centered music.",
            link: nil
        ),
        Suggestion(
            title: "Help someone who is struggling financially.",
            link: nil
        ),
        Suggestion(
            title: "Watch 'Because of Him' video.",
            link: URL(string: "https://www.churchofjesuschrist.org/media/video/2016-04-0100-because-of-him?lang=eng")
        ),
        Suggestion(
            title: "Study how Christ ministered to the marginalized.",
            link: nil
        ),
        Suggestion(
            title: "Read D&C 19:16-19 about Christ's suffering.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/dc-testament/dc/19?lang=eng")
        ),
        Suggestion(
            title: "Pray to develop Christlike attributes.",
            link: nil
        ),
        Suggestion(
            title: "Listen to 'O Come, O Come, Emmanuel.'",
            link: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/o-come-o-come-emmanuel?lang=eng")
        ),
        Suggestion(
            title: "Study the symbolism of the sacrament.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/manual/gospel-topics/sacrament?lang=eng")
        ),
        Suggestion(
            title: "Read 'Christ and the Rich Young Ruler' in Preach My Gospel.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/manual/preach-my-gospel-2023/03-lesson-1-the-message-of-the-restoration-of-the-gospel-of-jesus-christ?lang=eng")
        ),
        Suggestion(
            title: "Write down how Christ has blessed your life.",
            link: nil
        ),
        Suggestion(
            title: "Share a favorite Christmas scripture.",
            link: nil
        ),
        Suggestion(
            title: "Study Christ's teachings about love.",
            link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/nt/john/13.34-35?lang=eng")
        ),
        Suggestion(
            title: "Comfort someone who is grieving.",
            link: nil
        ),
        Suggestion(
            title: "Read about Christ calling His disciples.",
            link: nil
        ),
        Suggestion(
            title: "Display artwork of Christ in your home.",
            link: nil
        ),
        Suggestion(
            title: "Study the Joseph Smith translation insights about Christ.",
            link: nil
        ),
        Suggestion(
            title: "Listen to 'The Spirit of God.'",
            link: URL(string: "https://www.churchofjesuschrist.org/media/music/songs/the-spirit-of-god?lang=eng")
        ),
        Suggestion(
            title: "Make a list of everything you're grateful for to the Savior.",
            link: nil
        )
    ]
}
