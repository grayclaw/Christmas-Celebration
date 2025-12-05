//
//  SwipeableSuggestion.swift
//  Christmas Celebration
//
//  Created by Brian Homer Jr on 11/25/25.
//
import SwiftUI

// Model to track completion with date
struct CompletedSuggestion: Codable, Hashable {
    let title: String
    let completedDate: Date
}

struct SwipeableTextView: View {
    // Using @AppStorage to persist the completed suggestions between sessions
    @AppStorage("completedSuggestionsWithDates") private var completedSuggestionsData: Data = Data()
    
    @State private var suggestions = SuggestionContent.data
    @State private var completedSuggestions: [CompletedSuggestion] = []
    @State private var currentIndex = 0
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 20) {
            if suggestions.isEmpty {
                Text("No more suggestions!")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Swipeable carousel card
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .shadow(radius: 2)
                    
                    HStack(spacing: 16) {
                        // Left chevron button
                        Button(action: moveToPrevious) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .frame(width: 44, height: 44)
                        }
                        .disabled(suggestions.count <= 1)
                        .opacity(suggestions.count <= 1 ? 0.3 : 1.0)
                        
                        // Content
                        VStack(spacing: 12) {
                            Text(suggestions[currentIndex].title)
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 20)
                                .strikethrough(isCurrentCompleted, color: .red)
                                .foregroundColor(isCurrentCompleted ? .gray : .primary)
                            
                            // Show completion date if completed
                            if let completedDate = currentCompletionDate {
                                Text("Completed: \(completedDate, style: .date)")
                                    .font(.caption2)
                                    .foregroundColor(.green)
                                    .padding(.bottom, 4)
                            }
                            
                            if let url = suggestions[currentIndex].link {
                                Link("Learn More", destination: url)
                                    .font(.caption)
                                    .padding(.bottom, 8)
                            }
                            
                            // Check off button
                            Button(action: toggleComplete) {
                                HStack(spacing: 6) {
                                    Image(systemName: isCurrentCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(isCurrentCompleted ? .green : .gray)
                                    Text(isCurrentCompleted ? "Completed" : "Mark Complete")
                                        .font(.caption)
                                        .foregroundColor(isCurrentCompleted ? .green : .blue)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(isCurrentCompleted ? Color.green.opacity(0.1) : Color.blue.opacity(0.1))
                                .cornerRadius(8)
                            }
                            .padding(.bottom, 12)
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Right chevron button
                        Button(action: moveToNext) {
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .frame(width: 44, height: 44)
                        }
                        .disabled(suggestions.count <= 1)
                        .opacity(suggestions.count <= 1 ? 0.3 : 1.0)
                    }
                    .padding(.horizontal, 8)
                }
                .offset(x: dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            // Only allow horizontal drag
                            dragOffset = gesture.translation.width
                        }
                        .onEnded { gesture in
                            let threshold: CGFloat = 100
                            
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                if gesture.translation.width > threshold {
                                    // Swipe right - go to previous
                                    moveToPrevious()
                                } else if gesture.translation.width < -threshold {
                                    // Swipe left - go to next
                                    moveToNext()
                                }
                                dragOffset = 0
                            }
                        }
                )
                
                // Counter
                Text("\(currentIndex + 1) of \(suggestions.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                // Stats
                if !completedSuggestions.isEmpty {
                    Text("\(completedSuggestions.count) completed")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
                
                // Show recently completed items
                if !completedSuggestions.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recently Completed")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        
                        ForEach(recentCompletions, id: \.self) { completion in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.caption)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(completion.title)
                                        .font(.caption)
                                        .lineLimit(1)
                                    Text(completion.completedDate, style: .date)
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            
            Spacer()
        }
        .onAppear {
            loadCompletedSuggestions()
        }
    }
    
    private var isCurrentCompleted: Bool {
        guard currentIndex < suggestions.count else { return false }
        return completedSuggestions.contains(where: { $0.title == suggestions[currentIndex].title })
    }
    
    private var currentCompletionDate: Date? {
        guard currentIndex < suggestions.count else { return nil }
        return completedSuggestions.first(where: { $0.title == suggestions[currentIndex].title })?.completedDate
    }
    
    private var recentCompletions: [CompletedSuggestion] {
        completedSuggestions.sorted { $0.completedDate > $1.completedDate }.prefix(5).map { $0 }
    }
    
    private func moveToNext() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            if currentIndex < suggestions.count - 1 {
                currentIndex += 1
            } else {
                currentIndex = 0 // Loop back to start
            }
        }
    }
    
    private func moveToPrevious() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            if currentIndex > 0 {
                currentIndex -= 1
            } else {
                currentIndex = suggestions.count - 1 // Loop to end
            }
        }
    }
    
    private func toggleComplete() {
        guard currentIndex < suggestions.count else { return }
        let title = suggestions[currentIndex].title
        
        withAnimation(.easeInOut(duration: 0.3)) {
            if let index = completedSuggestions.firstIndex(where: { $0.title == title }) {
                // Remove completion
                completedSuggestions.remove(at: index)
            } else {
                // Add completion with current date
                let completion = CompletedSuggestion(title: title, completedDate: Date())
                completedSuggestions.append(completion)
            }
            saveCompletedSuggestions()
        }
    }
    
    // Persistence methods
    private func loadCompletedSuggestions() {
        if let decoded = try? JSONDecoder().decode([CompletedSuggestion].self, from: completedSuggestionsData) {
            completedSuggestions = decoded
        }
    }
    
    private func saveCompletedSuggestions() {
        if let encoded = try? JSONEncoder().encode(completedSuggestions) {
            completedSuggestionsData = encoded
        }
    }
}

#Preview {
    SwipeableTextView()
        .padding()
}
