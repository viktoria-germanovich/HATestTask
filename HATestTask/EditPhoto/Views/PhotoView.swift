//
//  PhotoView.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI

struct PhotoView: View {
    
    // MARK: - Properties
    
    @Binding var photoImage: UIImage?
    var onSave: (UIImage) -> Void
    
    // MARK: - Constant
    
    private let imageSize = CGSize(width: 300, height: 300)
    
    // MARK: - Private state
    
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var isFiltered = false
    
    @GestureState private var isInteracting: Bool = false
    
    // MARK: - Content
    
    var body: some View {
        VStack(spacing: 20) {
            // Photo with gestures
            imageView()
                .border(Color.yellow, width: 2)
                .clipped()
            
            // Save button
            Button("\(Const.save) 💾") {
                let renderer = ImageRenderer(content: imageView())
                renderer.proposedSize = .init(imageSize)
                renderer.scale = 3
                guard let image = renderer.uiImage else { return }
                onSave(image)
            }
            
            // Black & white toggle
            Toggle(Const.applyFilter, isOn: $isFiltered)
                .frame(width: 150)
        }
    }
    
    // MARK: - Views
    
    @ViewBuilder private func imageView() -> some View {
        GeometryReader { geometry in
            let containerSize = geometry.size
            Image(uiImage: photoImage ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .grayscale(isFiltered ? 1 : 0)
                .overlay(imageOverlay(containerSize))
                .frame(containerSize)
        }
        .scaleEffect(scale)
        .offset(offset)
        .coordinateSpace(name: Const.coordinateSpace)
        .gesture(dragGesture())
        .gesture(magnificationGesture())
        .frame(imageSize)
    }
    
    @ViewBuilder private func imageOverlay(_ containerSize: CGSize) -> some View {
        GeometryReader { proxy in
            let imageFrame = proxy.frame(in: .named(Const.coordinateSpace))
            
            Color.clear
                .onChange(of: isInteracting) { _, newValue in
                    if !newValue {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            adjustOffset(for: imageFrame, in: containerSize)
                        }
                        lastOffset = offset
                    }
                }
        }
    }
}

// MARK: - Functions

private extension PhotoView {
    
    // Gesture functions
    func dragGesture() -> some Gesture {
        DragGesture()
            .updating($isInteracting) { _, out, _ in
                out = true
            }
            .onChanged { value in
                offset = CGSize(width: value.translation.width + lastOffset.width,
                                height: value.translation.height + lastOffset.height)
            }
    }
    
    func magnificationGesture() -> some Gesture {
        MagnificationGesture()
            .updating($isInteracting) { _, out, _ in
                out = true
            }
            .onChanged { value in
                scale = max(1, value + lastScale)
            }
            .onEnded { _ in
                withAnimation(.easeInOut(duration: 0.2)) {
                    if scale < 1 {
                        scale = 1
                        lastScale = 0
                    } else {
                        lastScale = scale - 1
                    }
                }
            }
    }
    
    // Adjust the offset to prevent the image from moving outside the container's bounds
    func adjustOffset(for imageFrame: CGRect, in containerSize: CGSize) {
        if imageFrame.minX > 0 {
            offset.width -= imageFrame.minX
        }
        if imageFrame.minY > 0 {
            offset.height -= imageFrame.minY
        }
        if imageFrame.maxX < containerSize.width {
            offset.width += containerSize.width - imageFrame.maxX
        }
        if imageFrame.maxY < containerSize.height {
            offset.height += containerSize.height - imageFrame.maxY
        }
    }
}


// MARK: - Text

private extension PhotoView {
    enum Const {
        static let coordinateSpace = "PHOTOVIEW"
        static let save = "Save photo to Gallery"
        static let applyFilter = "Apply filter"
    }
}
