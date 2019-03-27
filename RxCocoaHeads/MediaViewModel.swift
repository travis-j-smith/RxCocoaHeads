//
//  MediaViewModel.swift
//  RxCocoaHeads
//
//  Created by Travis Smith on 3/17/19.
//  Copyright © 2019 Travis Smith. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MediaViewModel {
    private let networkManager: NetworkManager
    private let searchSubject = PublishSubject<String>()
    
    let search: AnyObserver<String>
    let media: Driver<[Media]>
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        search = searchSubject.asObserver()
        media = searchSubject
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest({ (query) -> Single<[Media]> in
                return networkManager.fetchMedia(withQuery: query)
                    .map({ $0.media })
                    .catchErrorJustReturn([])
            })
            .asDriver(onErrorJustReturn: [])
    }
}
