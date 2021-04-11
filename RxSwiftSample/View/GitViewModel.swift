//
//  GitViewModel.swift
//  RxSwiftSample
//
//  Created by Junyeong on 2021/04/11.
//

import Foundation
import RxSwift
import RxCocoa


class GitViewModel : ViewModelType{
    let networkMng: NetworkManager = NetworkManager()
    
    
    struct Input {
        let initView: Driver<Void>
        let selectedIndex: Driver<IndexPath>
        let searchText: Driver<String>
    }
    
    struct Output {
        let githubRepo: Driver<[RepoViewModel]>
        let selectedGitID: Driver<Int>
    }

    func processing(input: Input) -> Output {
        let initRepo = input.initView
            .flatMap{
                self.networkMng.searchGithubRepo(name: "JYlab")
                    .asDriver(onErrorJustReturn: [])
            }
        
        let searchRepo = input.searchText
            .filter{
                ($0.count > 2) && (Character($0).isASCII)
            }
            .throttle(.milliseconds(300))
            .distinctUntilChanged()
            .flatMapLatest { query in
                self.networkMng.searchGithubRepo(name: query)
                    .asDriver(onErrorJustReturn: [])
            }
        
        
        // 초기화면, search 화면의 text driver
        let githubRepos = Driver.merge(initRepo, searchRepo)
        
        let repoViewModels = githubRepos.map{ $0.map{ RepoViewModel(repoName: $0)} }
        
        let selectedRepoId = input.selectedIndex
            .withLatestFrom(githubRepos){ (indexPath, githubRepos) in
                return githubRepos[indexPath.item]
            }
            .map{ $0.id }
                
        return Output(githubRepo: repoViewModels,
                      selectedGitID: selectedRepoId)
    }

}

struct RepoViewModel{
    let name: String
    init(repoName: GithubRepo){
        self.name = repoName.name
    }
}
