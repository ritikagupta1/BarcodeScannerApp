//
//  BarcodeScannerViewController.swift
//  BarcodeScannerApp_SwiftUI
//
//  Created by Ritika Gupta on 06/01/25.
//

import UIKit
import AVKit // for dealing with camera and video

enum BarcodeScannerError {
    case invalidDeviceInput
    case invalidScannedValue
}

protocol ScannerVCDelegate: AnyObject {
    func didScanBarcode(barcode: String)
    func didSurfaceError(error: BarcodeScannerError)
}

final class BarcodeScannerViewController: UIViewController {
    var captureSession =  AVCaptureSession() // session to capture what is on the camera
    var previewLayer: AVCaptureVideoPreviewLayer? // the layer which is displayed on screen when we move the camera(camera preview layer)
    
    weak var delegate: ScannerVCDelegate?
    
    init(scannerVCDelegate: ScannerVCDelegate) {
        self.delegate = scannerVCDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = self.previewLayer else {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = self.view.layer.bounds
    }
    
    func setUpCaptureSession() {
        // check if we have a device for capturing the video
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        // Input from the device
        let videoInput: AVCaptureDeviceInput
        
        do {
            // Get Input from the device - It throws hence the do try catch block
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        // if it can add input, add it
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        // if it can add output, add it
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13, .qr]
            metaDataOutput.setMetadataObjectsDelegate(self, queue: .main)
        } else {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        
        self.view.layer.addSublayer(previewLayer!)
        
        
        captureSession.startRunning()
        
    }
}


extension BarcodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            delegate?.didSurfaceError(error: .invalidScannedValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            delegate?.didSurfaceError(error: .invalidScannedValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            delegate?.didSurfaceError(error: .invalidScannedValue)
            return
        }
        
        delegate?.didScanBarcode(barcode: barcode)
    }
}
