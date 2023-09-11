//
//  TheWidgetBundle.swift
//  TheWidget
//
//  Created by Henrik Schnettler on 15.07.23.
//

import WidgetKit
import SwiftUI

@main
struct TheWidgetBundle: WidgetBundle {
    var body: some Widget {
        TheWidget()
        if #available(iOS 16.1, *) {
            TheWidgetLiveActivity()
        }
    }
}
