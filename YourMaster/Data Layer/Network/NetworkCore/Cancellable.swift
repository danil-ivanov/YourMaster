

import Foundation

protocol Cancellable {
    var isCancelled: Bool { get }
    func cancel()
}

class SimpleCancellable: Cancellable {
    var isCancelled = false
    
    func cancel() {
        isCancelled = true
    }
}

class CancellableWrapper: Cancellable {
    var innerCancellable: Cancellable = SimpleCancellable()
    
    var isCancelled: Bool { return innerCancellable.isCancelled }
    
    func cancel() {
        innerCancellable.cancel()
    }
}

class URLSessionCancellable: Cancellable {
    var isCancelled: Bool = false
    let task: URLSessionTask?
    
    init(task: URLSessionTask?) {
        self.task = task
    }
    
    func cancel() {
        task?.cancel()
        isCancelled = true
    }
}
