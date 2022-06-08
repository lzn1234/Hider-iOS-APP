//
//  AddDetailViewController.swift
//  Voice_copy
//
//  Created by putao on 2022/6/7.
//

import UIKit

class AddDetailViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var appIcon: UIButton!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var hideAppIcon: UIButton!
    @IBOutlet weak var hideAppName: UILabel!
    @IBOutlet weak var appNameTextField: UITextField!
    
    @IBOutlet weak var pwdButton: UIButton!
    @IBOutlet weak var noPwdButton: UIButton!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var showSecureButton: UIButton!
    
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var hideViewHight: NSLayoutConstraint!
    
    var ispwd = true
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appNameTextField.delegate = self
    }
    
    
    // MARK: textFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        hideAppName.text = textField.text
    }
    
    
    // MARK: button touch event
    
    // 是否设置密码按钮
    @IBAction func setPwdEvent(_ sender: Any) {
        let button = sender as! UIButton
        ispwd = button.isEqual(pwdButton)
        
        pwdButton.isSelected = ispwd
        noPwdButton.isSelected = !ispwd
        
        // 根据情况判断是否隐藏密码输入框
        hideView.isHidden = !ispwd
        hideViewHight.constant = ispwd ? 250 : 200
    }
    
    // 密码输入框切换按钮
    @IBAction func showSecureEvent(_ sender: Any) {
        showSecureButton.isSelected = !showSecureButton.isSelected
        pwdTextField.isSecureTextEntry = !showSecureButton.isSelected
    }
    
    // 上传自定义头像
    @IBAction func uploadIconevent(_ sender: Any) {
        let tzImagePicker = TZImagePickerController()
        tzImagePicker.maxImagesCount = 1
        tzImagePicker.modalPresentationStyle = .fullScreen
        self.present(tzImagePicker, animated: true)
        tzImagePicker.didFinishPickingPhotosHandle = {
            (photos:[UIImage]?,assets:[Any]?,b:Bool) in
            
            let rskImageCroper = RSKImageCropViewController(image: (photos?.first)!, cropMode: .custom)
            rskImageCroper.modalPresentationStyle = .fullScreen
            rskImageCroper.delegate = self
            rskImageCroper.dataSource = self
            self.present(rskImageCroper, animated: true)
        }
    }
    
    // 确定修改
    @IBAction func confirmAddAppEvent(_ sender: Any) {
        
    }
    
}

extension AddDetailViewController: RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource {
    // 取消裁剪
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        controller.dismiss(animated: true)
    }
    
    // 图片已经被裁减
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        self.hideAppIcon.setImage(croppedImage, for: .normal)
        controller.dismiss(animated: true)
    }
    
    // 设置图片的位置和大小
    func imageCropViewControllerCustomMaskRect(_ controller: RSKImageCropViewController) -> CGRect {
        return CGRect.init(x: (screenWidth-100)/2, y: (screenHeight-100)/2, width: 50, height: 50)
    }
    
    // 设置裁剪框的位置和大小
    func imageCropViewControllerCustomMaskPath(_ controller: RSKImageCropViewController) -> UIBezierPath {
        let imageRect  = CGRect.init(x: 20, y: (screenHeight-screenWidth)/2, width: screenWidth-40, height: screenWidth-40)
        return UIBezierPath.init(roundedRect: imageRect, cornerRadius: 0)
    }
    
    func imageCropViewControllerCustomMovementRect(_ controller: RSKImageCropViewController) -> CGRect {
        return controller.maskRect
    }
}
