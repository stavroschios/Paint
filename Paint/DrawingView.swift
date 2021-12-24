//
//  DrawingView.swift
//  Paint
//
//  Created by Stavros Pachoundakis on 2021-12-24.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    // to capture drawing for saving into album
    @Binding var canvas: PKCanvasView
    @Binding var isDraw: Bool
    @Binding var type: PKInkingTool.InkType
    @Binding var color: Color
    
    // updating inkType
    var ink: PKInkingTool{
        PKInkingTool(type, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        
        canvas.tool = isDraw ? ink : eraser
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // updating tool whenever main View updates
        uiView.tool = isDraw ? ink : eraser
        
    }
}
