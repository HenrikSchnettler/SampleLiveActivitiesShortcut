//
//  ContentView.swift
//  WidgetSample
//
//  Created by Henrik Schnettler on 15.07.23.
//

import SwiftUI
import CoreData
import WidgetKit
import ActivityKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //State variable of the active Activity
    @State var widgetActivity: Activity<TheWidgetAttributes>?

    var body: some View {
        HStack{
            if ActivityAuthorizationInfo().areActivitiesEnabled
            {
                Button(action: {
                    startLiveActivity()
                }) {
                    Text("START")
                    Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
                }
                
                Button(action: {
                    Task{
                        await stopLiveActivity()
                    }
                }) {
                    Text("STOP")
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    private func startLiveActivity() {
        //the initial values of the live activities should be set with the model for the dynamic and static attributes
        let initialContentState = TheWidgetAttributes.ContentState(value: 10)
        let activityAttributes = TheWidgetAttributes(name: "Henrik")
        
        //Here the live activity content is saved which contains the current state which is the initial and the staleDate which tells the system when content of the live activity becomes outdated
        let activityContent = ActivityContent(state: initialContentState, staleDate: Calendar.current.date(byAdding: .minute, value: 30, to: Date())!)
        
        // Start the Live Activity.
        do {
            widgetActivity = try Activity.request(attributes: activityAttributes, content: activityContent)
            print("Live activity started \(String(describing: widgetActivity?.id)).")
        } catch (let error) {
            print("Error starting Live Activity: \(error.localizedDescription).")
        }
    }
    
    private func stopLiveActivity() async{
        // Stop the Live Activity.
        
        let finalStatus = TheWidgetAttributes.ContentState(value: 10)
        do {
            try await widgetActivity?.end(dismissalPolicy: .default)
        } catch (let error) {
            print("Error stopping Live Activity: \(error.localizedDescription).")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
