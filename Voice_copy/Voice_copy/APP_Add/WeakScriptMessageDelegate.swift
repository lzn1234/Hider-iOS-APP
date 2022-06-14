//
//  WeakScriptMessageDelegate.swift
//  Voice_copy
//
//  Created by putao on 2022/6/14.
//
// 解决循环引用问题
import UIKit
import WebKit
class WeakScriptMessageDelegate: NSObject ,WKScriptMessageHandler{
    weak var scriptDelegate:WKScriptMessageHandler?
    init(_ scriptDelegate:WKScriptMessageHandler) {
        self.scriptDelegate = scriptDelegate
        super.init()
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        scriptDelegate?.userContentController(userContentController, didReceive: message)
    }
    deinit {
        
    }

}

