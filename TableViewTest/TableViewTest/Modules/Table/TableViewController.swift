//
//  ViewController.swift
//  TableViewTest
//
//  Created by Guest User on 09/03/2020.
//  Copyright © 2020 Guest User. All rights reserved.
//

import UIKit
import ReachabilitySwift

class TableViewController: UIViewController {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var viewModel:TableViewModel!
    
    override func loadView() {
        super.loadView()
        safeArea = view.layoutMarginsGuide
        self.setupTableView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = TableViewModel()
        // Do any additional setup after loading the view.
        if Reachability.init()?.isReachableViaWiFi == true{
            print("Connected")
            self.refreshScreen()
        }else{
            let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(ok)
            present(controller, animated: true, completion: nil)
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.pullToRefreshControl?.addTarget(self, action: #selector(self.refreshScreen), for: .valueChanged)
        
    }
    
    @objc func refreshScreen(){
        self.tableView.programaticallyBeginRefreshing()
        self.viewModel.getData(onSuccess: {
            [weak self] in
            self?.tableView.pullToRefreshControl?.endRefreshing()
            self?.title = self?.viewModel.getTitle()
            self?.tableView.reloadData()
            }, onFailure: {
                [weak self] msg in
                self?.tableView.pullToRefreshControl?.endRefreshing()
                self?.showAlert(message:msg)
        })
    }
    
}

extension TableViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.setupViews(data: self.viewModel.getData(index: indexPath.row))
        return cell
    }
}

