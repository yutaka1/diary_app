//
//  SwiftUIView.swift
//  Syosabi
//
//  Created by SHIRAHATA YUTAKA on 2020/12/07.
//

import SwiftUI

struct CALayerView: UIViewControllerRepresentable {
    var caLayer:CALayer
    let RectSize = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.35)

    func makeUIViewController(context: UIViewControllerRepresentableContext<CALayerView>) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.layer.addSublayer(caLayer)
        caLayer.frame = viewController.view.layer.frame
        //caLayer.frame = viewController.view.alignmentRect(forFrame: RectSize)
        return viewController
    }
    //プレビュー動画をアップデートしている
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CALayerView>) {
        //caLayer.frame = uiViewController.view.alignmentRect(forFrame: RectSize)

    }
}

