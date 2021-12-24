//
//  Home.swift
//  DrawingPencilKit
//
//  Created by Stavros Pachoundakis on 2021-12-24.
//
import SwiftUI
import PencilKit
struct Home: View {
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color: Color = .black
    @State var type: PKInkingTool.InkType = .pen
    @State var colorPicker = false
    @State var splash = false
    @State var counter = 0
    // default is pen
    
    var body: some View {
        NavigationView {
          
            // Drawing View
            if #available(iOS 15.0, *) {
                DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $color)
                   
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems( leading:
                                            
                                            HStack{
                        
                        Button(action: {
                            // saving Image
                            SaveImage()
                        }) {
                            Image(systemName: "square.and.arrow.down")
                                .foregroundColor(Color.black)
                            
                                .font(.title3)
                        }
                        
                        Button(action: {
                            // delete draw
                            clearView()
                        }) {
                            Image(systemName: "x.circle")
                                .foregroundColor(Color.black)
                                .offset(y: 3)
                                .font(.title3)
                        }
                        Button(action: {
                            // Erase tool
                            isDraw = false
                        }) {
                            Image(systemName: "pencil.tip.crop.circle.badge.minus")
                                .font(.title3)
                                .foregroundColor(Color.black)
                        }
                    }, trailing: HStack {
                        
                        
                        ColorPicker("", selection: $color)
                        
                        
                        // Menu for InkType and Color
                        Menu {
                            // Color Picker
                            //                        Button(action: {
                            //                            colorPicker.toggle()
                            //                        }) {
                            //                            Label {
                            //                                Text("Color")
                            //                            } icon: {
                            //                                Image(systemName: "eyedropper.full")
                            //
                            //                            }
                            //                        }
                            
                            Button(action: {
                                // Changing tool
                                isDraw = true
                                type = .pencil
                            }) {
                                Label {
                                    Text("Pencil")
                                } icon: {
                                    Image(systemName: "pencil")
                                }
                            }
                            
                            Button(action: {
                                isDraw = true
                                type = .pen
                            }) {
                                Label {
                                    Text("Pen")
                                } icon: {
                                    Image(systemName: "pencil.tip")
                                    
                                }
                            }
                            
                            Button(action: {
                                isDraw = true
                                type = .marker
                            }) {
                                Label {
                                    Text("Marker")
                                } icon: {
                                    Image(systemName: "highlighter")
                                }
                            }
                        } label: {
                            Image("menu")
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        
                    }) .overlay{
                        if splash {
                        Rectangle().fill(Color.white)
                            .ignoresSafeArea(.all, edges: .all)
                            Splash()
                        }
                        
                    }
                    .sheet(isPresented: $colorPicker) {
                        
                    }
            } else {
                // Fallback on earlier versions
            }
         
        }
        
        .onAppear{
            splash.toggle()
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { _ in
                self.counter = counter + 1
                if counter == 3 {
                    splash = false
                }
            })
        }
       
    }
  
    func SaveImage() {
        // Getting image from canvas
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        
        // saving to albums
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    func clearView() {
        
        canvas.drawing = PKDrawing()
        
        
    }
}
