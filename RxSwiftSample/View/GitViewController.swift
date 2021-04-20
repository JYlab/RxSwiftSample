//
//  GitViewController.swift
//  RxSwiftSample
//
//  Created by Junyeong on 2021/04/11.
//

import UIKit
import RxSwift
import RxCocoa

class GitViewController : UIViewController {
    var viewModel : GitViewModel?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        bindViewModel()
    }
    
    private func bindViewModel(){
        
        guard let viewModel = self.viewModel else {
            NSLog("viewModel is nil")
            return
        }
        let input = GitViewModel.Input(initView: rx.viewWillAppear.asDriver(),
                                       selectedIndex: tableView.rx.itemSelected.asDriver(),
                                       searchText: searchBar.rx.text.orEmpty.asDriver())
        
        let output = viewModel.processing(input: input)
        output.githubRepo
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)){ (row, element, cell) in
                cell.textLabel?.text = element.name
            }
            .disposed(by: disposeBag)
        
        output.selectedGitID
            .drive(onNext: { [weak self] repoID in
                guard let strongSelf = self else { return }
                let alertContorller = UIAlertController(title: "\(repoID)", message: "TEST", preferredStyle: .alert)
                alertContorller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                strongSelf.present(alertContorller, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }    
}
