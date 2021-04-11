//
//  ViewModelType.swift
//  RxSwiftSample
//
//  Created by Junyeong on 2021/04/11.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func processing(input : Input) -> Output
}
