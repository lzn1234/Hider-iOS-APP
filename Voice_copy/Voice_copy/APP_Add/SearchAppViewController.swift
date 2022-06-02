//
//  SearchAppViewController.swift
//  Voice_copy
//
//  Created by putao on 2022/6/2.
//

import UIKit

class SearchAppViewController: UIViewController {


    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initView()
    }
    
    func initView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        self.tableView.register(UINib.init(nibName: String(describing: SearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SearchTableViewCell.self))
    }
}

extension SearchAppViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchTableViewCell.self)) as! SearchTableViewCell
        cell.appIcon.image = UIImage(named: "logo")
        cell.appName.text = "桌面加密大师"
        return cell
    }
    
}
