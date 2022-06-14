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
    
    var model: APPInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appIconImageVIew.sd_setImage(with: URL(string:model!.artworkUrl60))
        self.appIdTextfield.text = model?.bundleId
        self.appNameTextfield.text = model?.trackName
        
    }
    
    @IBAction func confirmAddAppIcon(_ sender: Any) {
        
        InterfaceService.shared.request(interface: .appLink(packageName: model!.bundleId, appVersion: model!.version), completion: nil)
        let tipInfoVC = TipInfoViewController()
        tipInfoVC.appName = model!.trackName
        tipInfoVC.iconImage = appIconImageVIew.image
        tipInfoVC.bundleID = model!.bundleId
        tipInfoVC.scheme = "douyinv1opensdk"
        self.navigationController?.pushViewController(tipInfoVC, animated: true)
    }
}
