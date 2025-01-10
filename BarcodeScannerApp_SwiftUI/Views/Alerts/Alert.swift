//
//  Alert.swift
//  BarcodeScannerApp_SwiftUI
//
//  Created by Ritika Gupta on 10/01/25.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button
}

struct AlertItems {
    static let invalidDeviceType = AlertItem(
        title: Text("Invalid Device"),
        message: Text("Something is wrong with the camera. We are unable to capture the video"),
        dismissButton: .default(Text("Ok")))
    
    static let invalidInputType = AlertItem(
        title: Text("Invalid Input"),
        message: Text("Something is wrong with input.This app scans EAN-8 & EAN-13 barcodes"),
        dismissButton: .default(Text("Ok")))
}
