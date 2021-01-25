//
//  InputData.swift
//  呑み日記
//
//  Created by SHIRAHATA YUTAKA on 2021/01/20.
//

import Foundation
import SwiftUI

class InputData: ObservableObject {
    
    //memo
    @Published var input: String {
        didSet {
            UserDefaults.standard.set(input, forKey: "input")
        }
    }
    
    //場所
    @Published var state: String {
        didSet {
            UserDefaults.standard.set(state, forKey: "state")
        }
    }
    
    //店
    @Published var shop: String {
        didSet {
            UserDefaults.standard.set(shop, forKey: "shop")
        }
    }
    
    //種類
    @Published var kind: String {
        didSet {
            UserDefaults.standard.set(kind, forKey: "kind")
        }
    }
    
    //産地
    @Published var product_area: String {
        didSet {
            UserDefaults.standard.set(product_area, forKey: "product_area")
        }
    }
    
    //初期化処理
    init() {
        input = UserDefaults.standard.string(forKey: "input") ?? ""
        state = UserDefaults.standard.string(forKey: "state") ?? ""
        shop = UserDefaults.standard.string(forKey: "shop") ?? ""
        kind = UserDefaults.standard.string(forKey: "kind") ?? ""
        product_area = UserDefaults.standard.string(forKey: "product_area") ?? ""
    }
    
}

