//
//  ContentView.swift
//  Note
//
//  Created by SHIRAHATA YUTAKA on 2020/12/20.
//

import SwiftUI

struct ContentView: View {
    @State var memonames: [String] = []
    @State var newMemo = ""
    
    var body: some View {
            NavigationView {
                VStack{
                List {
                    ForEach(memonames, id: \.self){ memoids in
                        NavigationLink(destination: WritingView()){
                            Text(memoids)
                        }
                    }
                    .onDelete(perform: delete)
                    //listの移動
                    .onMove { (indexSet, index) in
                        self.memonames.move(fromOffsets: indexSet, toOffset: index)}
                }
                .navigationBarTitle(Text("呑み日記"))
                .navigationBarItems(trailing: EditButton())
                
                //リストの追加処理
                HStack{
                    TextField("メッセージを入力", text: $newMemo).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.memonames.append(self.newMemo)
                        UIApplication.shared.closeKeyboard()
                        self.newMemo = ""
                    }) {
                        Text("追加")
                            .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
        }
    }
    //リストの削除を行う関数
    func delete(at offsets: IndexSet) {
           if let first = offsets.first {
               memonames.remove(at: first)
           }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
