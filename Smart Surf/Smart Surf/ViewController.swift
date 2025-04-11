//
//  ViewController.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 12.02.2025.
//

import Cocoa
import WebKit


class ViewController: NSViewController {
    
    @IBOutlet var url_field: NSTextField!
    
    @IBOutlet var result_field: NSTextField!
    
    var webView: WebViewLoader?
    
    @IBAction func onMakeRequst(_ sender: Any) {
        webView = WebViewLoader()
        
        let urlString = url_field.stringValue.trimmingCharacters(in: .whitespaces)
                
        guard !urlString.isEmpty else {
            result_field.stringValue = "Please enter a valid URL."
            return
        }
        
        webView?.makeRequest(url: urlString)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView?.resultHandler = { [weak self] text in
            DispatchQueue.main.async {
                self?.result_field.stringValue = text
            }
        }
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

