//
//  PostActivityView.swift
//  GetSocialSwiftUI
//
//  Created by Vass Gábor on 07/01/2020.
//  Copyright © 2020 Keywords Studios. All rights reserved.
//

import SwiftUI

struct PostActivityView: View {

    @State
    var postText: String = ""

    @ObservedObject
    var viewModel: ActivitiesViewModel

    @Environment(\.presentationMode)
    var presentationMode

    @State
    var postImage: Image?

    @State
    var showMediaPicker = false

    @State
    var selectedImage: UIImage?

    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }


    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                VStack(alignment: .center, spacing: 16) {
                    Text("Create Post").fontWeight(.bold)
                    TextField("Message", text: self.$postText).padding(8).border(Color.gray)
                    Text("Attachment").fontWeight(.bold)
                    HStack() {
                        Image(systemName: "camera.circle").resizable().frame(width: 32, height: 32, alignment: .center).onTapGesture {
                            self.showMediaPicker = true
                        }
                        Image(systemName: "video.circle").resizable().frame(width: 32, height: 32, alignment: .center)
                    }
                    postImage?.resizable().frame(maxHeight: 160).aspectRatio(0.4, contentMode: .fill).cornerRadius(2)
                    Button(action: {
                        self.viewModel.createPost(with: self.$postText.wrappedValue, imageAttachment: self.$selectedImage.wrappedValue)
                    }) {
                        Text("Send")
                    }.padding(.top, 16)
                    Spacer()
                }.sheet(isPresented: $showMediaPicker, onDismiss: loadImage) {
                    MediaPickerView(selectedImage: self.$selectedImage)
                }.onReceive(self.viewModel.$postCreated, perform: { newValue in
                    if newValue == false {
                        return
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }).padding(16)
            }
            if self.viewModel.showActivityIndicator {
                ActivityIndicatorView()
            }
        }
    }
}

struct PostActivityView_Previews: PreviewProvider {
    static var previews: some View {
        PostActivityView(viewModel: ActivitiesViewModel())
    }
}

struct MediaPickerView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode

    @Binding
    var selectedImage: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<MediaPickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MediaPickerView>) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: MediaPickerView

        init(_ parent: MediaPickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
