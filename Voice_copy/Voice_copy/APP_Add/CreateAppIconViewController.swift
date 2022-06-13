//
//  CreateAppIconViewController.swift
//  Voice_copy
//
//  Created by putao on 2022/6/9.
//

import UIKit
import SafariServices

class CreateAppIconViewController: UIViewController {
    
    @IBOutlet weak var appIconImageVIew: UIImageView!
    @IBOutlet weak var appIdTextfield: UITextField!
    @IBOutlet weak var appUrlTextfield: UITextField!
    @IBOutlet weak var appNameTextfield: UITextField!
    
    var webServer:GCDWebServer = {
       let webServer = GCDWebServer()
        webServer.addGETHandler(forBasePath: "/", directoryPath: NSHomeDirectory() + "Documents", indexFilename: nil, cacheAge: 3600, allowRangeRequests: true)
        return webServer
    }()
    
    var model: APPInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appIconImageVIew.sd_setImage(with: URL(string:model!.artworkUrl60))
        self.appIdTextfield.text = model?.bundleId
        self.appNameTextfield.text = model?.trackName
        
        // 启动 webServer 服务
        if webServer.isRunning == false {
            webServer.start(withPort: 8090, bonjourName: nil)
        }
    }
    @IBAction func confirmAddAppIcon(_ sender: Any) {
        
        InterfaceService.shared.request(interface: .appLink(packageName: model!.bundleId, appVersion: model!.version), completion: nil)
    }
}
