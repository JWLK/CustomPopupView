//
//  ContentView.swift
//  CustomPopupView
//
//  Created by JWLK on 2022/04/17.
//

import SwiftUI

struct ContentView: View {
    @State var popupShow: Bool = false
    @State var popupDismiss: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Button(action: {
                    popupShow.toggle()
                    popupDismiss.toggle()
                    
                }, label: {
                    Text("Popup")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                })
                
                if popupDismiss{
                   
                }
                BottomPopupView(popupShow: $popupShow,
                                popupDismiss: $popupDismiss,
                                height: UIScreen.main.bounds.height/2.2) {
                    PopupContents()
                        .padding()
                }
                .animation(.default)
            }
        }
    }
}

struct PopupContents: View {
    var body: some View {
        Text("Popup View")
            .bold()
            .font(.system(size: 30))
        
        Text("Contens dummy data test data is anything you want to write\n\rContens dummy data test data is anything you want to write\n\rContens dummy data test data is anything you want to write")
            .bold()
            .font(.system(size: 30))
            .multilineTextAlignment(.center)
    }
}

struct BottomPopupView<Content: View>: View {
    let content: Content
    @Binding var popupShow: Bool
    @Binding var popupDismiss: Bool
    let height: CGFloat
    
    init(popupShow: Binding<Bool>,
         popupDismiss: Binding<Bool>,
         height: CGFloat,
         @ViewBuilder content: () -> Content
    ) {
        self.height = height
        _popupShow = popupShow
        _popupDismiss = popupDismiss
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            //Background Contents
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.black.opacity(0.5))
            .opacity(popupShow ? 1 : 0)
            .animation(Animation.easeIn) 
            .onTapGesture {
                self.dismiss()
            }
            //Card Contents
            VStack {
                Spacer()
                VStack{
                    content
                    
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Text("Dismiss")
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width/1.5, height: 50)
                            .background(Color.pink)
                            .cornerRadius(8)
                    })
                    .padding()
                }
                .background(Color.white)
                .frame(height: height)
                .offset(y: popupDismiss && popupShow ? 0 : height)
                .animation(Animation.default.delay(0.2))
            }
        }.edgesIgnoringSafeArea(.all)
        
    }
    
    func dismiss() {
        popupDismiss.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            popupShow.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
