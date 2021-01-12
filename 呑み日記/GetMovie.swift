//
//  GetMovie.swift
//  Syosabi
//
//  Created by SHIRAHATA YUTAKA on 2020/12/09.
//

import UIKit
import AVFoundation
import Combine
import Photos
import PhotosUI


//class GetMovie: UIViewController, AVCaptureFileOutputRecordingDelegate {
//class GetMovie: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureFileOutputRecordingDelegate, ObservableObject {
class GetMovie: NSObject, AVCapturePhotoCaptureDelegate, ObservableObject {

    
    ///撮影した画像
    @Published var image: UIImage?
    //画像のキャプチャー
    @Published var iscapture:Bool = false

    // ビデオのアウトプット
    //private var myVideoOutput: AVCaptureMovieFileOutput!
    /*
    private var filewriter: AVAssetWriter?
    private var videoInput: AVAssetWriterInput?
    private var audioInput: AVAssetWriterInput?
    var lastTime: CMTime! // 最後に保存したデータのPTS
    var offsetTime = CMTime.zero
    */
    ///プレビュー用レイヤー
    var previewLayer:CALayer!
    //dataOutput
    //var dataOutput = AVCaptureVideoDataOutput()

    ///撮影開始フラグ
    @Published var takingmovie:Bool = false

    ///セッション
    public var photoOutput = AVCapturePhotoOutput()
    public var captureSession = AVCaptureSession()
    ///撮影デバイス
    private var capturepDevice:AVCaptureDevice!
    
    @Published var framerate:Int32 = 15
    @Published var Startrectime = Date().addingTimeInterval(0)
    
    //初期設定
    override init() {
        super.init()
        
        self.captureSession = AVCaptureSession()
        self.photoOutput = AVCapturePhotoOutput()

        prepareCamera()
        beginSession()
    }

    //方向の調整
    public func updateInputOrientation(orientation: UIDeviceOrientation) {
          for conn in captureSession.connections {
              conn.videoOrientation = ConvertUIDeviceOrientationToAVCaptureVideoOrientation(deviceOrientation: orientation)
          }
    }
    
    //イメージ画像の保存
    
    func captureimage(){
        if takingmovie == true{
            takingmovie = false
        }
        else{
            self.image = nil
            takingmovie = true
        }
        return
    }
    func takephoto(){
        let photoSetting = AVCapturePhotoSettings()
        photoSetting.flashMode = .auto
        photoSetting.isHighResolutionPhotoEnabled = false
        photoOutput.capturePhoto(with: photoSetting, delegate: self)
        takingmovie = false
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let imageData = photo.fileDataRepresentation()
        self.image = UIImage(data: imageData!)
    }
    
    //動画撮影とカメラロールへの保存
    /*
    func stopmovie(){
        isrecordmovie = false
        self.videoInput?.markAsFinished()
        self.filewriter?.finishWriting(completionHandler: {
              DispatchQueue.main.async {
                self.filewriter = nil // 録画終了
              }
          })
        self.outputVideos()
    }
 */
    //初期状態にフラグを戻す
    func clearall(){
        iscapture = false
        //isrecordmovie = false
    }
    //カメラデバイスの設定
    //初期化時に呼び出される
    private func prepareCamera() {
        captureSession.sessionPreset = .photo

        if let availableDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices.first {
            capturepDevice = availableDevice
        }
    }
    
    //初期化時に呼び出される
    private func beginSession() {
        captureSession.beginConfiguration()
        //デバイスの初期化
        do {
            // 指定したデバイスを使用するために入力を初期化
            //これがあるとプレビューが表示されなくなる
            let captureDeviceInput = try AVCaptureDeviceInput(device: capturepDevice)
            captureSession.addInput(captureDeviceInput)
            
            try capturepDevice.lockForConfiguration()
            capturepDevice.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: framerate)
            capturepDevice.activeVideoMaxFrameDuration = CMTimeMake(value: 1, timescale: framerate)
            capturepDevice.unlockForConfiguration()
            
        } catch {
            print(error.localizedDescription)
        }
        //カメラ映像を画面に出力する為の設定
        // 指定したAVCaptureSessionでプレビューレイヤを初期化
        //CALayerのサブクラス
        /*
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer
        */
        //写真の設定
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
    
        
        captureSession.commitConfiguration()
    }
 
    //startRunningメソッドにより、セッションの入力から出力までの流れが実行される
    func startSession() {
        if captureSession.isRunning { return }
        captureSession.startRunning()
    }
    //セッションのストップ
    func endSession() {
        if !captureSession.isRunning { return }
        captureSession.stopRunning()
    }
    
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    /*
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //let isVideo = output is AVCaptureVideoDataOutput
        if takingmovie {
            //previewから画像を取得し、BufferをUIImageに変換する
            if let image = getImageFromSampleBuffer(buffer: sampleBuffer) {
                //同期処理での呼び出し
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    */
    //captureOutputで使用
    //CMSampleBufferをUIImageに変換している
    /*
    private func getImageFromSampleBuffer (buffer: CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            if let image = context.createCGImage(ciImage, from: imageRect) {
                //return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
                return UIImage(cgImage: image, scale: UIScreen.main.scale/10, orientation: .up)
            }
        }
        return nil
    }
    */
    public func ConvertUIDeviceOrientationToAVCaptureVideoOrientation(deviceOrientation: UIDeviceOrientation) -> AVCaptureVideoOrientation {
        switch deviceOrientation {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        default:
            return .portrait
        }
    }
    
    /*
    func convertColor(source srcImage: UIImage) -> UIImage {
        //let CONTOUR_COLOR = Scalar(0.0, 0.0, 0.0, 0.0)
        let srcMat = Mat(uiImage: srcImage)
        let rotMat = Mat()
        let dstMat = Mat()

        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft{
            Imgproc.cvtColor(src: srcMat, dst: dstMat, code: .COLOR_RGB2BGRA)
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight{
            Core.rotate(src: srcMat, dst: rotMat, rotateCode: .ROTATE_180)
            Imgproc.cvtColor(src: rotMat, dst: dstMat, code: .COLOR_RGB2BGRA)
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.portrait{
            Core.rotate(src: srcMat, dst: rotMat, rotateCode: .ROTATE_90_CLOCKWISE)
            Imgproc.cvtColor(src: rotMat, dst: dstMat, code: .COLOR_RGB2BGRA)
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown{
            Core.rotate(src: srcMat, dst: rotMat, rotateCode: .ROTATE_90_COUNTERCLOCKWISE)
            Imgproc.cvtColor(src: rotMat, dst: dstMat, code: .COLOR_RGB2BGRA)
        }
        else{
            //Core.rotate(src: srcMat, dst: rotMat, rotateCode: .ROTATE_90_COUNTERCLOCKWISE)
            Core.rotate(src: srcMat, dst: rotMat, rotateCode: .ROTATE_90_CLOCKWISE)
            Imgproc.cvtColor(src: rotMat, dst: dstMat, code: .COLOR_RGB2BGRA)
        }
        
        return dstMat.toUIImage()
    }
 */
    
}
