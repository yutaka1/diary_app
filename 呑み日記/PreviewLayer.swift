//
//  PreviewLayer.swift
//  Note
//
//  Created by SHIRAHATA YUTAKA on 2020/12/31.
//

import Foundation
import AVFoundation
import SwiftUI
 
public class UIAVCaptureVideoPreviewView: UIView {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
 
    public init(frame: CGRect, session: AVCaptureSession) {
        self.captureSession = session
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        // no implementation
    }
 
    func setupPreview(previewSize: CGRect) {
        self.frame = previewSize
 
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer.frame = self.bounds
        
        self.updatePreviewOrientation()
 
        self.layer.addSublayer(previewLayer)
 
        self.captureSession.startRunning()
    }
    
    func updateFrame(frame: CGRect) {
        self.frame = frame
        self.previewLayer.frame = frame
    }
 
    func updatePreviewOrientation() {
        switch UIDevice.current.orientation {
        case .portrait:
            self.previewLayer.connection?.videoOrientation = .portrait
        case .portraitUpsideDown:
            self.previewLayer.connection?.videoOrientation = .portraitUpsideDown
        case .landscapeLeft:
            self.previewLayer.connection?.videoOrientation = .landscapeRight
        case .landscapeRight:
            self.previewLayer.connection?.videoOrientation = .landscapeLeft
        default:
            self.previewLayer.connection?.videoOrientation = .portrait
        }
        return
    }
}
 
public struct SwiftUIAVCaptureVideoPreviewView: UIViewRepresentable {
    let previewFrame: CGRect
    let captureModel: GetMovie
 
    public func makeUIView(context: Context) -> UIAVCaptureVideoPreviewView {
        let view = UIAVCaptureVideoPreviewView(frame: previewFrame, session: self.captureModel.captureSession)
        view.setupPreview(previewSize: previewFrame)
        return view
    }
    
    public func updateUIView(_ uiView: UIAVCaptureVideoPreviewView, context: Context) {
        print("in updateUIView")
        self.captureModel.updateInputOrientation(orientation: UIDevice.current.orientation)
        uiView.updateFrame(frame: previewFrame)
    }
}
