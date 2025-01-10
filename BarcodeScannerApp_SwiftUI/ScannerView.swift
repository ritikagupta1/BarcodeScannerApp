//
//  ScannerView.swift
//  BarcodeScannerApp_SwiftUI
//
//  Created by Ritika Gupta on 10/01/25.
//


import SwiftUI
struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
    func makeUIViewController(context: Context) -> BarcodeScannerViewController {
        return BarcodeScannerViewController(scannerVCDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: BarcodeScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: ScannerVCDelegate {
        let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didScanBarcode(barcode: String) {
            self.scannerView.scannedCode = barcode
        }
        
        func didSurfaceError(error: BarcodeScannerError) {
            switch error {
            case .invalidDeviceInput:
                scannerView.alertItem = AlertItems.invalidDeviceType
            case .invalidScannedValue:
                scannerView.alertItem = AlertItems.invalidInputType
            }
        }
    }
}
