//
//  SettingsView.swift
//  The Season of Christ
//
//  Created by Brian Homer Jr on 11/19/25.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @AppStorage("notificationHour") private var notificationHour: Int = 9
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false
    @State private var showingPermissionAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Daily Reminders")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                        .onChange(of: notificationsEnabled) { oldValue, newValue in
                            if newValue {
                                requestNotificationPermission()
                            } else {
                                cancelAllNotifications()
                            }
                        }
                    
                    if notificationsEnabled {
                        Stepper(value: $notificationHour, in: 6...22) {
                            Text("Remind me at \(notificationHour):00")
                        }
                        .onChange(of: notificationHour) { oldValue, newValue in
                            scheduleNotifications()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Notifications Disabled", isPresented: $showingPermissionAlert) {
                Button("Open Settings", action: openAppSettings)
                Button("Cancel", role: .cancel) {
                    notificationsEnabled = false
                }
            } message: {
                Text("Please enable notifications in Settings to receive daily reminders.")
            }
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    scheduleNotifications()
                } else {
                    notificationsEnabled = false
                    showingPermissionAlert = true
                }
            }
        }
    }
    
    private func scheduleNotifications() {
        // Cancel existing notifications first
        cancelAllNotifications()
        
        guard notificationsEnabled else { return }
        
        let center = UNUserNotificationCenter.current()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        
        // Schedule daily notifications from November 30 to December 24
        let startDate = DateComponents(calendar: calendar, year: currentYear, month: 11, day: 30).date!
        let endDate = DateComponents(calendar: calendar, year: currentYear, month: 12, day: 24).date!
        
        var currentDate = startDate
        var dayNumber = 1
        
        while currentDate <= endDate {
            let content = UNMutableNotificationContent()
            content.title = "Light of Christ - Day \(dayNumber)"
            content.body = "Your daily reflection is ready"
            content.sound = .default
            
            // Create date components for the notification
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
            dateComponents.hour = notificationHour
            dateComponents.minute = 0
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "day-\(dayNumber)", content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                }
            }
            
            // Move to next day
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            dayNumber += 1
        }
    }
    
    private func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
}
