//
//  ContentView.swift
//  BarcodeScannerApp_SwiftUI
//
//  Created by Ritika Gupta on 06/01/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer()
                    .frame(height: 60)
                    .background(.red)
                
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text("Not yet Scanned")
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(.green)
                    .padding()
                
               
            }
            .navigationTitle("Barcode Scanner")
        }
        
    }
}

#Preview {
    BarcodeScannerView()
}
