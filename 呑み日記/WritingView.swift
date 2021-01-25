//
//  WritingView.swift
//  Note
//
//  Created by SHIRAHATA YUTAKA on 2020/12/20.
//

import SwiftUI
import KeyboardObserving

//var isText:Bool = true

struct WritingView: View {
    /*
    @State var input:String = ""
    @State var state:String = ""
    @State var shop:String = ""
    @State var kind:String = ""
    @State var product_area:String = ""
    */
    /*
    let bred = 53
    let bgreen = 57
    let bblue = 63
    */
    @ObservedObject var inputdata = InputData()
    @State var input:String = ""
    //@State var bgacolor:UIColor
    let bgtopcolor = Color.init(red: 0.26, green: 0.27, blue: 0.39,opacity: 1.0)
    let bgcolor = Color.init(red: 0.26, green: 0.27, blue: 0.39,opacity: 1.0)
    let forcolor = Color.white
    let exforcolor = Color.white
    
    
    @ObservedObject var getmovie = GetMovie()
    @Environment(\.presentationMode) var presentation
    var body: some View {

        if getmovie.takingmovie == false{

            GeometryReader { geom in
                //ScrollView(.vertical){
                VStack(spacing: 0){
                        ZStack{
                            bgtopcolor
                            //Color.black
                                 .edgesIgnoringSafeArea(.vertical)
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
                            //前の画面への遷移ボタン
                            VStack{
                                HStack{
                                    Button(action: {
                                               self.presentation.wrappedValue.dismiss()
                                    }){
                                        Image(systemName: "arrowshape.turn.up.backward.2.fill")
                                            .resizable()
                                            .foregroundColor(Color.black)
                                            .background(Color.white)
                                            .frame(width: 25, height: 25)
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                    Divider()
                        .foregroundColor(Color.white)
                    
                        HStack{
                            Text("場所")
                                .bold()
                                .foregroundColor(exforcolor)
                            Spacer()
                            Text("種類")
                                .bold()
                                .foregroundColor(exforcolor)
                            Spacer()
                        }
                        .background(bgcolor)
                        //.background(Color.black)
                        HStack{
                            Group{
                                TextField("ex:東京", text: $inputdata.state)
                                    .foregroundColor(forcolor)
                                Spacer()
                                TextField("ex:ビール", text: $inputdata.kind)
                                    .foregroundColor(forcolor)
                                Spacer()
                            }
                            //.background(Color.init(red: 0.53, green: 0.57, blue: 0.63,opacity: 1))
                            .background(bgcolor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 1)
                                    .stroke(Color.white, lineWidth: 1))
                        }
                        .background(bgcolor)
                        //.background(Color.black)
                        HStack{
                            Text("お店")
                                .bold()
                                .foregroundColor(exforcolor)
                            Spacer()
                            Text("産地")
                                .bold()
                                .foregroundColor(exforcolor)
                            Spacer()
                        }
                        .background(bgcolor)
                        //.background(Color.black)
                        HStack{
                            Group{
                                TextField("ex:~店", text: $inputdata.shop)
                                Spacer()
                                TextField("ex:東京", text: $inputdata.product_area)
                                Spacer()
                            }
                            .background(Color.clear)
                            .foregroundColor(forcolor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 1)
                                    .stroke(Color.white, lineWidth: 1))
                            
                        }
                        .background(bgcolor)
                        //.background(Color.black)
                        HStack{
                            Text("メモ")
                                .bold()
                            Spacer()
                        }
                        .foregroundColor(exforcolor)
                        .background(bgcolor)
                        //.background(Color.black)
                        

                            
                        
                        //TextView("", text: self.$input)
                    MultilineTextField(text: $inputdata.input)//, bgacolor: $bgacolor)//UIColor(displayP3Red: bred, green: bgreen, blue: bblue, alpha: 1.0))
                            .frame(width: UIScreen.main.bounds.width * 1.0, height: UIScreen.main.bounds.height*0.2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 1)
                                    .stroke(Color.black, lineWidth: 1)
                            //        .background(Color.gray)
                            )
                            .foregroundColor(forcolor)
                            .background(bgcolor)
                            //.background(Color.black)
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .onTapGesture{
                        //inputdata.input = self.input
                        UIApplication.shared.closeKeyboard()
                    }
                    //.padding(.bottom, keyboard.keyboardHeight)
                /*
                    .onAppear{
                        self.input = inputdata.input
//                        self.keyboard.startObserve()
                    }
 */
                /*
                    .onDisappear(){
                        self.keyboard.stopObserve()
                    }
 */
                    
                    
                //}
                
            }
        }
        //写真の取得画面
        else{
            GeometryReader { geom in
                VStack{
                    SwiftUIAVCaptureVideoPreviewView(previewFrame: CGRect(x: 0, y: geom.size.height*0.05, width: geom.size.width, height: geom.size.height),captureModel: getmovie)
                        
                    
                    Button(action: {
                        getmovie.takephoto()
                    }){
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

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MultilineTextField: UIViewRepresentable{
    @Binding var text: String
    //@Binding var bgacolor: UIColor
    
    func makeUIView(context: Context) -> UITextView{
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(red: 0.26, green: 0.27, blue: 0.39, alpha: 1.0)
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = UIColor.white
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
