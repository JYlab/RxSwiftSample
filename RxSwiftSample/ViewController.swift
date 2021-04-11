//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Junyeong on 2021/04/11.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var githubLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGitViewEvent()
    }
    
    func setupGitViewEvent(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(githubLabelTapped(_:)))
        githubLabel.addGestureRecognizer(tapGestureRecognizer)
        githubLabel.isUserInteractionEnabled = true
    }
    
    @objc func githubLabelTapped(_ sender: UITapGestureRecognizer) {
        print("hello")
     
        let storyBoard: UIStoryboard = UIStoryboard(name:"GitView", bundle:nil)
        let viewController = storyBoard.instantiateViewController(identifier: "GitViewControllerID")
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gitView = segue.destination
        guard let gitVC = gitView as? GitViewController else{
            return
        }
        gitVC.viewModel = GitViewModel()
    }
    
     
    
    
    
    
    
}

