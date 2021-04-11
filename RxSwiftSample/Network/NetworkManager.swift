//
//  NetworkManager.swift
//  RxSwiftSample
//
//  Created by Junyeong on 2021/04/12.
//

import Foundation
import RxSwift
import RxCocoa

class NetworkManager{
    func searchGithubRepo(name: String) -> Observable<[GithubRepo]>{
        let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=\(name)")!)
        return URLSession.shared.rx.data(request: request)
            .map{ data -> [GithubRepo] in
                guard let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                    return [] }
                return response.items
            }
    }
}

struct SearchResponse: Decodable {
    let items: [GithubRepo]
}
