//
//  LoadingMoreManager.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import Foundation
import UIKit

protocol LoadingMoreMangerDelegate: NSObjectProtocol {
    func loadingMoreManager(manager: LoadingMoreManger, willLoadmoreWithCompletionHandler completionHandler: () -> Void)
    func loadingMoreManagerShouldTriggerLoadingMore(manager: LoadingMoreManger) -> Bool
}

class LoadingMoreManger: NSObject {
    private var scrollView: UIScrollView
    private var loading = false
    weak var delegate: LoadingMoreMangerDelegate?
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init()
    }
    
    func triggerLoadingMore() {
        if loading { return }
        if !shouldTriggerLoadingMore() { return }
        guard let delete = delegate else { return }
        loading = true
        delete.loadingMoreManager(self, willLoadmoreWithCompletionHandler: {
            self.loading = false
        })
    }
    
    private func shouldTriggerLoadingMore() -> Bool {
        guard let delegate = delegate else { return false }
        return delegate.loadingMoreManagerShouldTriggerLoadingMore(self) && scrollView.scrolledToEnd
    }
}