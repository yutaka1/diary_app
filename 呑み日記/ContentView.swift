//
//  ContentView.swift
//  Note
//
//  Created by SHIRAHATA YUTAKA on 2020/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Note_Content()){
                Text("Start App")
                    .frame(width: 100, height: 30,
                           alignment: .center)
                    .background(Color.red)
                    .foregroundColor(Color.white)
            }
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
