//
//  MediaViewController.swift
//  RxCocoaHeads
//
//  Created by Travis Smith on 3/17/19.
//  Copyright © 2019 Travis Smith. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class MediaViewController: UIViewController {
    private static let cellIdentifier = "CellIdentifier"
    
    private let viewModel: MediaViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MediaViewController.cellIdentifier)
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autocapitalizationType = .words
        return searchBar
    }()
    
    init(viewModel: MediaViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureBindings()
    }
    
    private func setupUI() {
        title = "OMDb Media"
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
    
    private func configureBindings() {
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)
        
        viewModel.media
            .drive(tableView.rx.items(cellIdentifier: MediaViewController.cellIdentifier)) { (_, media, cell) in
                cell.textLabel?.text = media.title
            }
            .disposed(by: disposeBag)
    }
}
