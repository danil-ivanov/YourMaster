

import Foundation

class DispatcherResponse {
    let statusCode: Int
    let data: Data
    let request: URLRequest?
    let response: HTTPURLResponse?
    
    public init(statusCode: Int, data: Data, request: URLRequest? = nil, response: HTTPURLResponse? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
}
