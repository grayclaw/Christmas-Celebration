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
    @State private var dailySuggestion: DailySuggestion? = {
        // Check if running in test mode
        if ProcessInfo.processInfo.arguments.contains("--testing"),
           let testDateStr = ProcessInfo.processInfo.environment["TEST_DATE"] {
            
            // Parse the test date string (format: "2025-11-25")
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            if let testDate = formatter.date(from: testDateStr) {
                // Find the suggestion for this test date
                return DailySuggestion.allSuggestions.first { suggestion in
                    Calendar.current.isDate(suggestion.date, inSameDayAs: testDate)
                }
            }
        }
        
        return DailySuggestion.today()
    }()
    @State private var showSettings = false
    let theSaviorsName = ["The Messiah"
                          , "The Redeemer"
                          , "The Savior"
                          , "Immanuel"
                          , "The Son of God"
                          , "The Son of Man"
                          , "The Lamb of God"
                          , "The Good Shepherd"
                          , "Light of the World"
                          , "The Prince of Peace"
                          , "The King of Kings"
                          , "The Lord of Lords"
                          , "The Word"
                          , "Alpha and Omega"
                          , "The Bread of Life"
                          , "The True Vine"
                          , "The Way"
                          , "The Truth"
                          , "The Life"
                          , "The Holy One of Israel"
                          , "The Mediator"
                          , "The Advocate"
                          , "The Rock"
                          , "The Bridegroom"
                          , "The Deliverer"
                          , "The Great High Priest"
                          , "The Morning Star"
                          , "The Resurrection and the Life"
                          , "The Anointed One"
                          , "The Only Begotten"]

    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        Image(.nativity)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .clipped()

                        VStack(alignment: .center, spacing: 16) {

                            if let daily = dailySuggestion {
                                Text(theSaviorsName[daily.day - 1])
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.top, 16)
                                // Day header
                                Text("Day \(daily.day)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.top, 8)

                                Text(daily.date, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                // Scripture Card
                                SuggestionCard(
                                    title: "Scripture",
                                    description: daily.scripture,
                                    link: daily.scriptureLink
                                )

                                // Talk Card
                                SuggestionCard(
                                    title: "Message",
                                    description: daily.talkTitle,
                                    link: daily.talkLink
                                )

                                // Daily Suggestion Card
                                SuggestionCard(
                                    title: "Daily Suggestion",
                                    description: daily.suggestion,
                                    link: daily.suggestionLink
                                )
                            } else {
                                Text("Daily content begins November 25th—see you then for the countdown to Christmas!")
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
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
