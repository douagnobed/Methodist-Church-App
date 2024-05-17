//
//  PaymentView.swift
//  MethodistMobile
//
//  Created by Q002 on 21/02/2024.
//

import SwiftUI
import WebKit

struct PaymentView: View {
 
    let webview = Webview(web: nil, req: URLRequest(url: URL(string: "https://mcrp.qliqintegrations.com/support-project")!))

    var body: some View {
       
            ZStack{
               
                VStack{
                    CustomAppbar(title: "Payment")
                    webview
                    
                }
                
                
            }
            
     
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
            PaymentView()
    }
}


func webView(_ webView: WKWebView,
       runJavaScriptConfirmPanelWithMessage message: String,
            initiatedByFrame frame: WKFrameInfo,
            completionHandler: @escaping (Bool) -> Void) {

           // confirm functionality goes here. THIS CRASHES THE APP
           let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
               completionHandler(true)
           }))

           alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
               completionHandler(false)
           }))

           alertController.present(alertController, animated: true, completion: nil)
       }




struct Webview : UIViewRepresentable {
    let request: URLRequest
    var webview: WKWebView?

    init(web: WKWebView?, req: URLRequest) {
        self.webview = WKWebView()
        self.request = req
    }

    class Coordinator: NSObject, WKUIDelegate {
        var parent: Webview

        init(_ parent: Webview) {
            self.parent = parent
        }

        // Delegate methods go here

        func webView(_ webView: WKWebView,
        runJavaScriptAlertPanelWithMessage message: String,
             initiatedByFrame frame: WKFrameInfo,
             completionHandler: @escaping () -> Void) {

            // alert functionality goes here
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            alertController.present(alertController, animated: true)

            completionHandler()

        }

        func webView(_ webView: WKWebView,
        runJavaScriptConfirmPanelWithMessage message: String,
             initiatedByFrame frame: WKFrameInfo,
             completionHandler: @escaping (Bool) -> Void) {

            // confirm functionality goes here. THIS CRASHES THE APP
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                completionHandler(true)
            }))

            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                completionHandler(false)
            }))

            alertController.present(alertController, animated: true, completion: nil)
        }

        func webView(_ webView: WKWebView,
        runJavaScriptTextInputPanelWithPrompt prompt: String,
                  defaultText: String?,
             initiatedByFrame frame: WKFrameInfo,
             completionHandler: @escaping (String?) -> Void) {

            // prompt functionality goes here

        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.uiDelegate = context.coordinator
        uiView.load(request)
    }

    func goBack(){
        webview?.goBack()
    }

    func goForward(){
        webview?.goForward()
    }

    func reload(){
        webview?.reload()
    }
}

extension View {
    public func currentDeviceNavigationViewStyle() -> AnyView {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return AnyView(self.navigationViewStyle(DefaultNavigationViewStyle()))
        } else {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        }
    }
}
