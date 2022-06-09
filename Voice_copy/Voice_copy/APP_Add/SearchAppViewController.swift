//
//  SearchAppViewController.swift
//  Voice_copy
//
//  Created by putao on 2022/6/2.
//

import UIKit
import IQKeyboardManagerSwift

class SearchAppViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var appStoreModel:APPStoreModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "确定"
        // 初始化默认列表
        doSearch(inputStr: "抖音")
    }
    
    func initView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        self.tableView.register(UINib.init(nibName: String(describing: SearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SearchTableViewCell.self))
        
        self.search.delegate = self
        self.search.clearButtonMode = .always
    }
    
    //MARK: TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        doSearch(inputStr: textField.text ?? "")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        doSearch(inputStr: textField.text ?? "")
    }
    
    
    func doSearch(inputStr: String){
        
        let searchStr = inputStr != "" ? inputStr : "抖音"
        
        APPStoreModel.getAppInfoFromAppStore(withAppName: searchStr) { result in
            self.appStoreModel = result
            self.tableView.reloadData()
        }
    }
    
}

//MARK: UITableView Delegate And Datasource
extension SearchAppViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appStoreModel?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchTableViewCell.self)) as! SearchTableViewCell
        let model:APPInfoModel = appStoreModel!.results[indexPath.row];
        cell.appIcon.sd_setImage(with: URL(string: model.artworkUrl60))
        cell.appName.text = model.trackName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreateAppIconViewController()
        vc.model = appStoreModel?.results[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
