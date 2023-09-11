//
//  TheWidgetModel.swift
//  WidgetSample
//
//  Created by Henrik Schnettler on 15.07.23.
//

import Foundation
import ActivityKit
import WidgetKit

//This model must be set target to the app project and the widget extension

struct TheWidgetAttributes: ActivityAttributes {
    //a public alias for the ContentState object (Here we can give a name for variables which go to one object)
    public typealias WidgetDynamicVariables = ContentState
    
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
