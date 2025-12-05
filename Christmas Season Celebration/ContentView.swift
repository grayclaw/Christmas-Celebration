//
//  ContentView.swift
//  The Season of Christ
//
//  Created by Brian Homer Jr on 11/19/25.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var currentDailyContent: DailyContent?
    @State private var currentDay: Int?
    @State private var holidayDate: Date?
    @State private var saviorName: String = ""
    @State private var currentImage: ImageResource = .nativity1
    @State private var showSettings = false
    
    let easterContent = EasterContent.data
    let christmasContent = ChristmasContent.data

    let images: [ImageResource] = [
        .bethlehemInn,
        .carpentersSon,
        .journeyToBethlehem1,
        .journeyToBethlehem2,
        .journeyToBethlehem3,
        .maryBabyJesus,
        .maryJosephBabyJesus,
        .maryJosephJesusTemple,
        .maryYoungJesus,
        .nativity1,
        .nativity2,
        .nativity3,
        .nativity4,
        .nativity5,
        .nativity6,
        .nativity7,
        .presentationTemple1,
        .presentationTemple2,
        .presentationTemple3,
        .presentationTemple4,
        .prophetIsaiahForetellsBirth,
        .shepherdsAngel,
        .shepherdsNativity,
        .shepherdsStar,
        .star,
        .teachingAtTemple1,
        .teachingAtTemple2,
        .wiseMen1,
        .wiseMen2,
        .wiseMen3,
    ]

    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        Image(currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .clipped()

                        VStack(alignment: .center, spacing: 16) {
                            if let daily = currentDailyContent, let day = currentDay {
                                Text(saviorName)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.top, 16)
                                
                                // Day header
                                Text("Day \(day)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.top, 8)

                                Text(Date(), style: .date)
                                    .font(.subheadline)

                                // Scripture Card
                                ScriptureCard(
                                    title: "Scripture",
                                    description: daily.scripture.reference,
                                    scripture: daily.scripture.textVariable,
                                    link: daily.scripture.link
                                )

                                // Message Card
                                SuggestionCard(
                                    title: "Message",
                                    description: daily.talk.title,
                                    link: daily.talk.link
                                )

                                // Daily Suggestion Card
                                SuggestionCard(
                                    title: "Daily Suggestion",
                                    description: "Read and ponder 'The Living Christ.'",
                                    link: URL(string: "https://www.churchofjesuschrist.org/study/scriptures/the-living-christ-the-testimony-of-the-apostles/the-living-christ-the-testimony-of-the-apostles?lang=eng")
                                )
                            } else {
                                Text("Daily content begins 30 days before Christmas and Easter — see you then!")
                                    .padding()
                                    .font(.title)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .multilineTextAlignment(.center)
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .edgesIgnoringSafeArea(.top)

                // Settings button overlaid on top
                Button(action: {
                    showSettings.toggle()
                }) {
                    Image(systemName: "gearshape.fill")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                .padding(.top, 0)
                .padding(.trailing, 16)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .presentationDetents([.medium])
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            loadDailyContent()
        }
    }
    
    private func loadDailyContent() {
        let countdown = getHolidayCountdown()
        
        // Check Christmas first, then Easter
        if let christmas = countdown.christmas {
            // We're in Christmas countdown period
            currentDay = christmas.dayNumber
            holidayDate = christmas.holidayDate
            
            // Get the content for this day (arrays are 0-indexed, days are 1-indexed)
            if christmas.dayNumber > 0 && christmas.dayNumber <= christmasContent.count {
                currentDailyContent = christmasContent[christmas.dayNumber - 1]
                // Get a name from the list (wrap around if needed)
                saviorName = namesOfChrist[(christmas.dayNumber - 1) % namesOfChrist.count]
                currentImage = images[(christmas.dayNumber - 1) % images.count]
            }
        } else if let easter = countdown.easter {
            // We're in Easter countdown period
            currentDay = easter.dayNumber
            holidayDate = easter.holidayDate
            
            // Get the content for this day
            if easter.dayNumber > 0 && easter.dayNumber <= easterContent.count {
                currentDailyContent = easterContent[easter.dayNumber - 1]
                // Get a name from the list (wrap around if needed)
                saviorName = namesOfChrist[(easter.dayNumber - 1) % namesOfChrist.count]
                currentImage = images[(easter.dayNumber - 1) % images.count]
            }
        } else {
            // Not in any countdown period
            currentDailyContent = nil
            currentDay = nil
            holidayDate = nil
        }
    }
}

struct SuggestionCard: View {
    let title: String
    let description: String
    let link: URL?

    var body: some View {
        Group {
            if let link = link {
                Link(destination: link) {
                    cardContent
                }
            } else {
                cardContent
            }
        }
    }

    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(description)
                .font(.title2)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct ScriptureCard: View {
    @State private var isToggled = false
    let title: String
    let description: String
    let scripture: String
    let link: URL?

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                isToggled.toggle()
            }) {
                cardContent
            }
            
            if isToggled {
                VStack(spacing: 8) {
                    Text(scripture)
                        .font(.body)
                        .padding()
                    
                    if let link = link {
                        Link(destination: link) {
                            HStack {
                                Text("Read on ChurchofJesusChrist.org")
                                    .font(.caption)
                                Image(systemName: "arrow.up.right.square")
                                    .font(.caption)
                            }
                            .foregroundColor(.blue)
                        }
                        .padding(.bottom, 8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
            }
        }
        .cornerRadius(12)
        .shadow(radius: 2)
    }

    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(description)
                .font(.title2)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
