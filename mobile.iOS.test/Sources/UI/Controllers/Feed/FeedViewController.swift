//
//  SnapKitViewController.swift
//  mobile.iOS.test
//
//  Created by Sergey Bondarchuk on 25.02.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//
import UIKit
import SnapKit
import Moya

class FeedViewController: UIViewController {
    let screenNext = UIView()
    let tableView = UITableView()
    var viewModels = [FeedCellViewModel]()
    let feedInfo = ServiceOfRickAndMorty()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviewsAndSetupConstraints()
        configureTableView()
        feedInfo.listOfCharacter { [weak self] result in
            guard let resultMap = result.results?.compactMap(FeedCellViewModel.init) else {return}
            self?.viewModels = resultMap
            self?.tableView.reloadData()
        }
    }
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedCell.self, forCellReuseIdentifier: "Cell")
    }
    func addSubviewsAndSetupConstraints() {
        view.addSubview(screenNext)
        view.addSubview(tableView)
        view.backgroundColor = UIColor.white
        tableView.rowHeight = 150.0
        tableView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
}
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailInfoViewController(id: viewModels[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                       for: indexPath) as? FeedCell else {
                                                        return UITableViewCell()
        }
        cell.configure(vm: viewModels[indexPath.row])
        return cell
    }
}
