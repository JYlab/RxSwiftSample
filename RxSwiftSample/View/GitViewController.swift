//
//  GitViewController.swift
//  RxSwiftSample
//
//  Created by Junyeong on 2021/04/11.
//

import Foundation
import UIKit

class GitViewController : UIViewController {
    var viewModel : GitViewModel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchController: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func bindViewModel(){
        
    }
    
    
    
}
