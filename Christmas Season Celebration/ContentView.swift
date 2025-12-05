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
    @State private var maxDay: Int? // Maximum day reached so far
    @State private var viewingDay: Int? // Day currently being viewed
    @State private var holidayDate: Date?
    @State private var saviorName: String = ""
    @State private var currentImage: ImageResource = .nativity1
    @State private var showSettings = false
    @State private var isViewingHistory = false
    
    let easterContent = EasterContent.data
    let christmasContent = ChristmasContent.data

    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        Image(currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            .clipped()
                        
                        VStack(alignment: .center, spacing: 16) {
                            if let daily = currentDailyContent, let day = viewingDay ?? currentDay {
                                // History navigation bar
                                if let maxDay = maxDay, maxDay > 1 {
                                    HStack(spacing: 20) {
                                        Button(action: goToPreviousDay) {
                                            Image(systemName: "chevron.left.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.blue)
                                        }
                                        .disabled(!canGoToPreviousDay)
                                        .opacity(canGoToPreviousDay ? 1.0 : 0.3)
                                        
                                        VStack(spacing: 4) {
                                            Text("Day \(day)")
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                            
                                            // Fixed height container for the button
                                            Group {
                                                if isViewingHistory {
                                                    Button(action: returnToToday) {
                                                        Text("Return to Today")
                                                            .font(.caption)
                                                            .foregroundColor(.blue)
                                                    }
                                                } else {
                                                    Text("Return to Today") // Invisible spacer
                                                        .font(.caption)
                                                }
                                            }
                                            .frame(height: 16) // Fixed height to prevent shifting
                                        }
                                        
                                        Button(action: goToNextDay) {
                                            Image(systemName: "chevron.right.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.blue)
                                        }
                                        .disabled(!canGoToNextDay)
                                        .opacity(canGoToNextDay ? 1.0 : 0.3)
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(12)
                                    .padding(.top, 16)
                                } else {
                                    Text("Day \(day)")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .padding(.top, 16)
                                }
                                
                                Text(saviorName)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.top, 8)

                                Text(dateForDay(day), style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                // Scripture Card
                                ScriptureCard(
                                    title: "Scripture",
                                    description: daily.scripture.reference,
                                    scripture: daily.scripture.textVariable,
                                    link: daily.scripture.link
                                )

                                // Message Card
                                GenericCard(
                                    title: "Message",
                                    description: daily.talk.title,
                                    link: daily.talk.link
                                )

                                // Daily Suggestion Card (only show for current day)
                                if !isViewingHistory {
                                    SwipeableTextView()
                                } else {
                                    Text("Daily suggestions are only available for today")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .padding()
                                }
                                
                            } else {
                                Text("Daily content begins 30 days before Christmas and Easter – see you then!")
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
    
    // MARK: - Navigation Helpers
    
    private var canGoToPreviousDay: Bool {
        guard let viewing = viewingDay else { return false }
        return viewing > 1
    }
    
    private var canGoToNextDay: Bool {
        guard let viewing = viewingDay, let max = maxDay else { return false }
        return viewing < max
    }
    
    private func goToPreviousDay() {
        guard let viewing = viewingDay, viewing > 1 else { return }
        viewingDay = viewing - 1
        loadContentForDay(viewing - 1)
        isViewingHistory = (viewingDay != currentDay)
    }
    
    private func goToNextDay() {
        guard let viewing = viewingDay, let max = maxDay, viewing < max else { return }
        viewingDay = viewing + 1
        loadContentForDay(viewing + 1)
        isViewingHistory = (viewingDay != currentDay)
    }
    
    private func returnToToday() {
        viewingDay = currentDay
        if let day = currentDay {
            loadContentForDay(day)
        }
        isViewingHistory = false
    }
    
    private func dateForDay(_ day: Int) -> Date {
        guard let holidayDate = holidayDate else { return Date() }
        // Calculate the date for this day (counting backwards from holiday)
        let daysBeforeHoliday = 30 - day + 1
        return Calendar.current.date(byAdding: .day, value: -daysBeforeHoliday, to: holidayDate) ?? Date()
    }
    
    // MARK: - Content Loading
    
    private func loadDailyContent() {
        let images = ChristAssets.images
        let names = ChristAssets.namesOfChrist
        let countdown = getHolidayCountdown()
        
        // Check Christmas first, then Easter
        if let christmas = countdown.christmas {
            // We're in Christmas countdown period
            currentDay = christmas.dayNumber
            maxDay = christmas.dayNumber
            viewingDay = christmas.dayNumber
            holidayDate = christmas.holidayDate
            
            // Get the content for this day (arrays are 0-indexed, days are 1-indexed)
            if christmas.dayNumber > 0 && christmas.dayNumber <= christmasContent.count {
                currentDailyContent = christmasContent[christmas.dayNumber - 1]
                saviorName = names[(christmas.dayNumber - 1) % names.count]
                currentImage = images[(christmas.dayNumber - 1) % images.count]
            }
        } else if let easter = countdown.easter {
            // We're in Easter countdown period
            currentDay = easter.dayNumber
            maxDay = easter.dayNumber
            viewingDay = easter.dayNumber
            holidayDate = easter.holidayDate
            
            // Get the content for this day
            if easter.dayNumber > 0 && easter.dayNumber <= easterContent.count {
                currentDailyContent = easterContent[easter.dayNumber - 1]
                saviorName = names[(easter.dayNumber - 1) % names.count]
                currentImage = images[(easter.dayNumber - 1) % images.count]
            }
        } else {
            // Not in any countdown period
            currentDailyContent = nil
            currentDay = nil
            maxDay = nil
            viewingDay = nil
            holidayDate = nil
        }
        
        isViewingHistory = false
    }
    
    private func loadContentForDay(_ day: Int) {
        let images = ChristAssets.images
        let names = ChristAssets.namesOfChrist
        
        // Determine which holiday content to use based on holidayDate
        let content: [DailyContent]
        if holidayDate != nil {
            // Check if we're in Christmas or Easter period
            let countdown = getHolidayCountdown()
            if countdown.christmas != nil {
                content = christmasContent
            } else {
                content = easterContent
            }
        } else {
            return
        }
        
        // Load content for the specified day
        if day > 0 && day <= content.count {
            currentDailyContent = content[day - 1]
            saviorName = names[(day - 1) % names.count]
            currentImage = images[(day - 1) % images.count]
        }
    }
}

// MARK: - Supporting Views

struct GenericCard: View {
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
                        .padding(.bottom, 20)
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
