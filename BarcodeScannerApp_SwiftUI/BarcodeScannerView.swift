//
//  ContentView.swift
//  BarcodeScannerApp_SwiftUI
//
//  Created by Ritika Gupta on 06/01/25.
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

struct BarcodeScannerView: View {
    @State private var scannedCode: String = ""
    @State private var alertItem: AlertItem?
    
    var body: some View {
        NavigationStack {
            VStack {
                ScannerView(scannedCode: $scannedCode,
                            alertItem: $alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer()
                    .frame(height: 60)
                
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not yet Scanned": scannedCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(scannedCode.isEmpty ? .red : .green)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $alertItem) { alertItem in
                Alert(
                    title: alertItem.title,
                    message: alertItem.message,
                    dismissButton: alertItem.dismissButton)
            }
        }
        
    }
}

#Preview {
    BarcodeScannerView()
}
