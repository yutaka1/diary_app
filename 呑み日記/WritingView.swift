//
//  WritingView.swift
//  Note
//
//  Created by SHIRAHATA YUTAKA on 2020/12/20.
//

import SwiftUI
import KeyboardObserving

var isText:Bool = true


struct WritingView: View {
    @State var input:String = ""
    @ObservedObject var getmovie = GetMovie()
    var body: some View {
        if getmovie.takingmovie == false{
            GeometryReader { geom in
                    VStack{
                        //Spacer(minLength: 10)
                        ScrollView(.vertical){
                            //Spacer(minLength: geom.size.height*0.15)
                            ZStack{
                                //imageの表示
                                if getmovie.image != nil{
                                    Image(uiImage: getmovie.image!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                        //.edgesIgnoringSafeArea(.top)
                                    //再撮影ボタン
                                    VStack{
                                        HStack{
                                            Spacer()
                                            Button(action: {
                                                getmovie.captureimage()
                                            }){
                                                Image(systemName: "return")
                                                    .resizable()
                                                    .foregroundColor(Color.black)
                                                    .background(Color.white)
                                                    .frame(width: 20, height: 20)
                                            }
                                        }
                                        Spacer()
                                    }
                                }
                                else{
                                    
                                    Rectangle()
                                        .stroke(lineWidth: 0)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color.white)
                                        .scaledToFit()
                                        //.edgesIgnoringSafeArea(.top)
     
                                    //写真取得ボタン
                                    Button(action: {
                                        getmovie.captureimage()
                                    }){
                                        Image(systemName: "camera.circle")
                                            .resizable()
                                            .foregroundColor(Color.black)
                                            .background(Color.white)
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            }

                            
                            
                        
                        /*
                        .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height)
                        .border(Color.black, width: 1)
                        */
                        
                        //ScrollView(.vertical){
                        /*
                            TextView(" Input text", text: self.$input)
                                .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height*0.3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.red, lineWidth: 1))
     */
                        //}
                        //.frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height*0.3)
                        //.border(Color.black, width: 1)
                            
    /*
                                .onEvent(onChanged: {
                                                //self.isEditing = true
                                            }, onEnded: {
                                                //self.version += 1
                                            })
                                //Spacer(minLength: 20)
     */
                        
                        /*
                        TabView{
                            Text(input)
                                .tabItem{
                                    Text("保存")
                                }
                            MultilineTextField(text: $input)
                                .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height*0.4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.red, lineWidth: 5))
                                .tabItem{
                                    Text("編集")
                                }
                        }
    */
                                            
                           
    /*
                        HStack{
                            //写真取得ボタン
                            Button(action: {
                                isText = false
                            }){
                                Text("編集")
                                    .foregroundColor(Color.black)
                                    .background(Color.white)
                                    .frame(width: 50, height: 50)
                            }
                            Spacer()
                            //写真取得ボタン
                            Button(action: {
                                isText = true
                            }){
                                Text("保存")
                                    .foregroundColor(Color.black)
                                    .background(Color.white)
                                    .frame(width: 50, height: 50)
                            }
                            
                        }
    */
                            
                        }
                        TextView(" Input text", text: self.$input)
                            .frame(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height*0.3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.red, lineWidth: 1))
                            .keyboardObserving()
                        
                  
                   
                    
                }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
               
                
                //.edgesIgnoringSafeArea(.top)
        //.frame(width: bodyView
          //      .size.width*0.5, height: bodyView.size.height*0.2)
            }
                
        }
        else{
            GeometryReader { geom in
                VStack{
                    SwiftUIAVCaptureVideoPreviewView(previewFrame: CGRect(x: 0, y: geom.size.height*0.05, width: geom.size.width, height: geom.size.height),captureModel: getmovie)
                        
                    
                    Button(action: {
                        getmovie.takephoto()
                    }){
                        /*
                        Text("写真の取得")
                            .foregroundColor(Color.red)
                            .background(Color.black)
                            .fixedSize()
                            .font(.custom("Arial", size: 30))
 */
                        Image(systemName: "camera.circle")
                            .resizable()
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .frame(width: 50, height: 50)
                    }
                    .padding(20)
                    
                }
                .onAppear {//viewが出てきたときの実行アクション
                    self.getmovie.startSession()
                }.onDisappear{//viewが閉じるときの実行アクション
                    self.getmovie.endSession()
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct MultilineTextField: UIViewRepresentable{
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView{
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text{
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator : NSObject, UITextViewDelegate{
        var parent: MultilineTextField
        
        init(_ textView: MultilineTextField){
            self.parent = textView
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
    }
    
}


struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}
