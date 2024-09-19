//
//  EditPhotoView.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI
import PhotosUI

struct EditPhotoView: View {
    
    // MARK: - ViewModel
    
    @StateObject private var viewModel = EditPhotoViewModel()

    // MARK: - Content
    
    var body: some View {
        ZStack {
            NavigationStack {
                // Photo content
                VStack() {
                    photoContainer
                }
                .navigationTitle(Const.Text.screenTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    // Photo picker
                    ToolbarItem(placement: .topBarTrailing) {
                        photoPicker
                    }
                }
            }
            .onChange(of: viewModel.photoItem) {
                Task { await viewModel.updatePhoto() }
            }
            
            // Progress view
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                ProgressView()
                    .frame(width: 25, height: 25)
            }
        }
    }
    
    // MARK: - Views
    
    private var photoPicker: some View {
        PhotosPicker(selection: $viewModel.photoItem, matching: .images) {
            HStack {
                Text(Const.Text.addPhoto)
                Image(systemName: Const.Image.plus)
                    .resizable()
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    private var photoContainer: some View {
        Group {
            if let _ = viewModel.selectedPhoto {
                VStack {
                    // Photo content
                    PhotoView(photoImage: $viewModel.selectedPhoto) { photo in
                        viewModel.savePhoto(photo)
                    }
                    .alert(viewModel.saveAlertText, isPresented: $viewModel.saveAlert) {
                        Button(Const.Text.okButton, role: .cancel) { }
                    }
                }
            } else {
                Text(Const.Text.noPhoto)
                    .foregroundStyle(.black.opacity(0.5))
            }
        }
    }
}

// MARK: - Constants

private extension EditPhotoView {
    enum Const {
        enum Text {
            static let screenTitle = "Edit Photo"
            static let addPhoto = "Add"
            static let noPhoto = "No photo selected"
            static let okButton = "OK"
        }
        
        enum Image {
            static let plus = "plus"
        }
    }
}

#Preview {
    EditPhotoView()
}
