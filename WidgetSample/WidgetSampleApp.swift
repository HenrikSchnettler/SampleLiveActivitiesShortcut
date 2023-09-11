//
//  WidgetSampleApp.swift
//  WidgetSample
//
//  Created by Henrik Schnettler on 15.07.23.
//

import SwiftUI

@main
struct WidgetSampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
