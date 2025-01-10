//
//  ContentView.swift
//  BarcodeScannerApp_SwiftUI
//
//  Created by Ritika Gupta on 06/01/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    @StateObject private var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScannerView(scannedCode:$viewModel.scannedCode,
                            alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer()
                    .frame(height: 60)
                
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(viewModel.statusText)
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(viewModel.statusTextColor)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $viewModel.alertItem) { alertItem in
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
