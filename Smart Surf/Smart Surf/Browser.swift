//
//  Browser.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 18.03.2025.
//

import SwiftUI
import WebKit

class Page : Identifiable, ObservableObject {
    var url: String = ""
    var name: String = ""
    let id = UUID()
    
    init(){
        name = "new page"
        url = "https://www.google.com"
    }
    
    init(url: String, name: String){
        self.url = url
        self.name = name
    }
}

class PageContainer: ObservableObject {
    @Published var pages: [Page] = []
    
    func addPage(_ page: Page) {
        self.pages.append(page)
    }
    func removePage(index: UUID) {
        pages.removeAll { $0.id == index }
    }
}

struct PageView: View {
    @ObservedObject var page: Page
    @EnvironmentObject var pageContainer: PageContainer
    
    var body: some View {
        HStack{
            Text(page.name)
                .font(.headline)
            Spacer()
            Button("x"){
                pageContainer.removePage(index: page.id)
            }
        }
    }
}

struct PageContainerView: View {
    @EnvironmentObject var pageContainer: PageContainer
    
    
    var body: some View {
        HStack {
            ForEach(pageContainer.pages) { page in
                PageView(page: page)
            }
            .onDelete(perform: removePage)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func removePage(at offsets: IndexSet) {
        pageContainer.pages.remove(atOffsets: offsets)
    }
}

class WebViewModel: ObservableObject {
    let webView = WKWebView()
    
    func loadURL(_ url: String) {
        if let requestURL = URL(string: url) {
            webView.load(URLRequest(url: requestURL))
        }
    }
    
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

struct WebView: NSViewRepresentable {
    @ObservedObject var model: WebViewModel
    
    func makeNSView(context: Context) -> WKWebView {
        return model.webView
    }
    
    func updateNSView(_ webView: WKWebView, context: Context) {}
}

struct ContentView: View {
    @StateObject var pageContainer = PageContainer()
    @State private var url: String = "https://www.apple.com"
    @StateObject private var webViewModel = WebViewModel()

    var body: some View {
        VStack {
            HStack {
                Button("←") {
                    webViewModel.goBack()
                }
                .padding()
                
                Button("→") {
                    webViewModel.goForward()
                }
                .padding()
                
                TextField("Enter URL", text: $url, onCommit: {
                    webViewModel.loadURL(url)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .frame(width: 300)
                
                Button("Go") {
                    webViewModel.loadURL(url)
                    let newPage = Page(url: url, name: "newPage")
                    pageContainer.addPage(newPage)
                    print(pageContainer.pages.count)
                }
                .padding()
            }
            
            PageContainerView()
            .environmentObject(pageContainer)
            
            WebView(model: webViewModel)
                .frame(minWidth: 600, minHeight: 400)
        }
    }
}

@main
struct SimpleBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
