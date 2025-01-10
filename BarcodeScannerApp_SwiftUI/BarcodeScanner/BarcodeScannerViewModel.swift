//
//  BarcodeScannerViewModel.swift
//  BarcodeScannerApp_SwiftUI
//
//  Created by Ritika Gupta on 10/01/25.
//

import SwiftUI

class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode: String = ""
    @Published  var alertItem: AlertItem?
    
    var statusText: String {
       scannedCode.isEmpty ? "Not yet Scanned": scannedCode
    }
    
    var statusTextColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
}
