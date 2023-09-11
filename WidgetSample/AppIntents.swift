//
//  AppIntents.swift
//  WidgetSample
//
//  Created by Henrik Schnettler on 15.07.23.
//

import Foundation
import AppIntents
import ActivityKit
import WidgetKit

struct TestIntent: AppIntent {
  static let title: LocalizedStringResource = "Test Activity"

  func perform() async throws -> some ReturnsValue & ProvidesDialog {
    return .result(
      value: "Test",
      dialog: "TEST"
    )
  }
}

struct LiveActivityIntent: LiveActivityStartingIntent {
  static let title: LocalizedStringResource = "Launch the Live Activity"

  func perform() async throws -> some ReturnsValue & ProvidesDialog {
      
      //the initial values of the live activities should be set with the model for the dynamic and static attributes
      let initialContentState = TheWidgetAttributes.ContentState(value: 10)
      let activityAttributes = TheWidgetAttributes(name: "Test")
      
      //Here the live activity content is saved which contains the current state which is the initial and the staleDate which tells the system when content of the live activity becomes outdated
      let activityContent = ActivityContent(state: initialContentState, staleDate: Calendar.current.date(byAdding: .minute, value: 30, to: Date())!)
      
      // Start the Live Activity.
      do {
          let widgetActivity = try Activity.request(attributes: activityAttributes, content: activityContent)
      } catch (let error) {
          print("Error starting Live Activity: \(error.localizedDescription).")
      }
    return .result(
      value: "Test",
      dialog: "TEST"
    )
  }
}

struct LiveActivityShortcuts: AppShortcutsProvider{
    static var appShortcuts: [AppShortcut]{
        AppShortcut(
            intent: TestIntent(),
            phrases: ["TEST"]
        )
    }
}
