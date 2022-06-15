//
//  TipInfoViewController.swift
//  Voice_copy
//
//  Created by putao on 2022/6/14.
//

import UIKit
import WebKit
import SafariServices

class TipInfoViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate{
    
    // app相关属性
    var iconImage: UIImage?
    var appName = ""
    var bundleID = ""
    var scheme = ""
    var pwd = ""
    var withPwd = 1
    
    //
    var fileStr = ""
    
    // 懒加载启动本地服务器
    lazy var webServer: GCDWebServer = {
        let webServer = GCDWebServer()
        webServer.addGETHandler(forBasePath: "/", directoryPath: NSHomeDirectory(), indexFilename: nil, cacheAge: 3600, allowRangeRequests: true)
        webServer.start(withPort: 8080, bonjourName: "GCD Web Server")
        return webServer
    }()
    
    // 懒加载初始化 WKWebView
    lazy var webView: WKWebView = {
        
        let preference = WKWebpagePreferences()
        preference.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preference
        configuration.selectionGranularity = .character
        configuration.userContentController = WKUserContentController()
        configuration.userContentController.add(WeakScriptMessageDelegate(self), name: "downloadClick")
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20), configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if !webServer.isRunning {
            webServer.start(withPort: 8080, bonjourName: "GCD Web Server")
        }
        
        view.addSubview(webView)
        webView.layer.cornerRadius = 5
        webView.layer.masksToBounds = true
        
        let htmlPath = Bundle.main.path(forResource: "help", ofType: "html")
        webView.load(URLRequest(url: URL(fileURLWithPath: htmlPath!)))
        
    }
    
    // MARK: WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        createConfigFile()
    }
    
    // 构建 APP 桌面图标对应文件
    func createConfigFile() {
        // 使用时间戳生成唯一标识
        let timeInterval: TimeInterval = NSDate().timeIntervalSince1970
        let timeStamp = String(Int(timeInterval))
        
        // 创建文件,并使用 safari 从本地文件中下载
        createFile()
        
        let fileName = appName + ".mobileconfig"
        let path = NSHomeDirectory() + "/Documents/" + fileName
        var tem = self.webServer.serverURL == nil ? URL(string: "http://127.0.0.1:8080/") : self.webServer.serverURL
        tem = tem?.appendingPathComponent("Documents/" + fileName, isDirectory: false)
        
        let strUrl = "http://127.0.0.1:8080/" + fileName
        let  temUrl = URL(string:strUrl)
        
        let safariVC:SFSafariViewController = SFSafariViewController.init(url: (tem ?? temUrl)!)
        safariVC.delegate = self;
        safariVC.modalPresentationStyle = .fullScreen
        
        if #available(iOS 13.0, *) {
            safariVC.isModalInPresentation = true
        }
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func createFile() {
        // 使用 base64 的图片
        let iconData:NSData = (iconImage!.jpegData(compressionQuality: 0.7)!) as NSData
        let base64Image = iconData.base64EncodedString(options: .lineLength64Characters)
        
        let uuid1 = NSUUID().uuidString
        let uuid2 = NSUUID().uuidString
        
        scheme += "://"
        
        let appconfigStr = ChageLogoMobileconfig.createOneAppConfig(withIcon: base64Image, isRemoveFromDestop: true, appName: appName , uuid: uuid1, bundleId: bundleID, url: scheme)
        // 文件字符串
        fileStr = ChageLogoMobileconfig.addConfigIntoGroup(withConfigs: appconfigStr, appSetName: (appName ) + "的logo描述文件", uuid: uuid2)
        
        // 文件存储位置
        let fileName = appName + ".mobileconfig"
        let path = NSHomeDirectory() + "/Documents/" + fileName
        
        if !FileManager.default.fileExists(atPath: path) {
            FileManager.default.createFile(atPath: path, contents: fileStr.data(using: .utf8), attributes: nil)
        } else {
            appName = appName + "1"
            createFile()
        }
    }
}

extension TipInfoViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString )!, options: [:], completionHandler: nil)
        webServer.stop()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

