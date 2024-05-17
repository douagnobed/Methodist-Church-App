//
//  CustomInputField.swift
//  MethodistMobile
//
//  Created by Q002 on 26/02/2024.
//

import SwiftUI

struct CustomInputField: View {
    var multilineTextFiled:Bool = false
    var lineLimit:Int =  5
    var prefixIcon: String? = nil
    var suffixIcon: String? = nil
    var placeholder: String? = nil
    var isPasswordField:Bool = false
    var isDisabled:Bool = false
    @Binding var text: String
    
    @State private var isEditing:Bool = false
    @State private var edges = EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 0)
    @State private var fontSize:CGFloat = 16
    @FocusState private var focusField:Field?
    
    private enum Field:Int, Hashable{
        case fieldName
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack{
                if (prefixIcon != nil) {
                    Image(systemName: prefixIcon ?? "person").foregroundColor(Color.gray)
                        .onTapGesture {
                        self.focusField = .fieldName
                    }
                }
                if(multilineTextFiled){
                    TextEditor( text: $text)
                        .lineLimit(lineLimit).onChange(of: text) { status in
                            DispatchQueue.main.async {
                                isEditing = (!status.isEmpty)
                                withAnimation {
                                    if(isEditing || !text.isEmpty){
                                        edges = EdgeInsets(top: 0, leading: 25, bottom: 55, trailing: 0)
                                        fontSize = 14
                                    }else{
                                        edges = EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 0)
                                        fontSize = 16
                                    }
                                }
                            }
                        }.focused($focusField, equals: .fieldName).disabled(isDisabled)
                }
                else{
                    if(isPasswordField){
                        SecureField("", text: $text){
                            DispatchQueue.main.async {
                                isEditing = false
                                withAnimation {
                                    if(isEditing || !text.isEmpty){
                                        edges = EdgeInsets(top: 0, leading: 25, bottom: 55, trailing: 0)
                                        fontSize = 14
                                    }else{
                                        edges = EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 0)
                                        fontSize = 16
                                    }
                                }
                            }
                        }
                      .onTapGesture {
                            DispatchQueue.main.async {
                                isEditing = true
                                withAnimation {
                                    if(isEditing || !text.isEmpty){
                                        edges = EdgeInsets(top: 0, leading: 25, bottom: 55, trailing: 0)
                                        fontSize = 14
                                    }else{
                                        edges = EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 0)
                                        fontSize = 16
                                    }
                                }
                            }
                        }
                      .focused($focusField, equals: .fieldName).disabled(isDisabled)
                    }
                        
                    else{
                        TextField("", text: $text){ status in
                            DispatchQueue.main.async {
                                isEditing = status
                                withAnimation {
                                    if(isEditing || !text.isEmpty){
                                        edges = EdgeInsets(top: 0, leading: 25, bottom: 55, trailing: 0)
                                        fontSize = 14
                                    }else{
                                        edges = EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 0)
                                        fontSize = 16
                                    }
                                }
                            }
                        }.focused($focusField, equals: .fieldName)
                            .disabled(isDisabled)
                    }
                }
                
                if (suffixIcon != nil) {
                    Image(systemName: suffixIcon ?? "person").foregroundColor(Color.gray)
                }
            }.padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
            Text(placeholder ?? "")
                .font(.system(size: fontSize))
                .background(Color(UIColor.systemBackground))
                .foregroundColor(Color.gray)
                .padding(edges)
                .animation(Animation.easeInOut(duration: 0.4), value: edges)
                .animation(Animation.easeInOut(duration: 0.4), value: fontSize)
                .onTapGesture {
                    self.focusField = .fieldName
                    isEditing = true
                    edges = EdgeInsets(top: 0, leading: 25, bottom: 55, trailing: 0)
                    fontSize = 14
                }
        }.onAppear{
            if(multilineTextFiled){
                isEditing = false
                edges = EdgeInsets(top: 0, leading: 45, bottom: 300, trailing: 0)
                fontSize = 16
            }
            else{
                if(!text.isEmpty || focusField == .fieldName){
                    isEditing = true
                    edges = EdgeInsets(top: 0, leading: 25, bottom: 55, trailing: 0)
                    fontSize = 14
                    
                }else{
                    isEditing = false
                    edges = EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 0)
                    fontSize = 16
                }
            }
        }
    }
}




//Multiline textFieldk

struct MultiTextView: UIViewRepresentable {
    var placeholder: String
    var backgroundColor:Color?
    @Binding var text: String

    var minHeight: CGFloat
    @Binding var calculatedHeight: CGFloat

    init(placeholder: String, text: Binding<String>, minHeight: CGFloat, calculatedHeight: Binding<CGFloat>) {
        self.placeholder = placeholder
        self._text = text
        self.minHeight = minHeight
        self._calculatedHeight = calculatedHeight
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator

        // Decrease priority of content resistance, so content would not push external layout set in SwiftUI
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = backgroundColor != nil ?UIColor(self.backgroundColor!): UIColor(white: 0.0, alpha: 0.05)

        // Set the placeholder
        textView.text = placeholder
        textView.textColor = UIColor.lightGray

        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        textView.text = self.text

        recalculateHeight(view: textView)
    }

    func recalculateHeight(view: UIView) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if minHeight < newSize.height && $calculatedHeight.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = newSize.height // !! must be called asynchronously
            }
        } else if minHeight >= newSize.height && $calculatedHeight.wrappedValue != minHeight {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = self.minHeight // !! must be called asynchronously
            }
        }
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: MultiTextView

        init(_ uiTextView: MultiTextView) {
            self.parent = uiTextView
        }

        func textViewDidChange(_ textView: UITextView) {
            // This is needed for multistage text input (eg. Chinese, Japanese)
            if textView.markedTextRange == nil {
                parent.text = textView.text ?? String()
                parent.recalculateHeight(view: textView)
            }
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor.lightGray
            }
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CustomInputField(prefixIcon: "person",text: .constant("username"))
            
            MultiTextView(placeholder: "Message", text: .constant(""), minHeight: CGFloat(150), calculatedHeight: .constant(CGFloat(150)))
                .frame(minHeight: CGFloat(150), maxHeight: CGFloat(150))
        }
    }
}
