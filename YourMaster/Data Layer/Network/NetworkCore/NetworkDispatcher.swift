
import Foundation

enum NetworkError: LocalizedError, Error {
    case badPath
    case badInput
    case unknown
    case responseError(data: Data?)
    case urlSessionError(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .badPath:
            return "Bad path"
        case .badInput:
            return "Bad input"
        case .unknown:
            return "Unknown"
        case .urlSessionError(let error):
            return error.localizedDescription
        case .responseError(_):
            return nil
        }
    }
}

// Имплементация Dispatcher с использованием URLSession

class NetworkDispatcher: Dispatcher {
    
    public static let defaultDispatcher: NetworkDispatcher = NetworkDispatcher()
    
    private var tasks = [URL: URLSessionTask]()
    private(set) weak var urlSessionTaskDelegate: URLSessionTaskDelegate?
    
    func setDelegate(_ delegate: URLSessionTaskDelegate) {
        self.urlSessionTaskDelegate = delegate
    }
    
    @discardableResult
    func execute(request: Request, completion: @escaping NetworkDispatcherCompletion) -> Cancellable {
        let session: URLSession
        
        if let delegate = urlSessionTaskDelegate {
            let configuration = URLSessionConfiguration.default
            session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        } else {
            session = URLSession.shared
        }
        
        do {
            let urlRequest = try self.prepareURLRequest(for: request)
            print("URLREQUEST \(urlRequest)")
            if let httpBody = urlRequest.httpBody {
                let httpBodyString = String(bytes: httpBody, encoding: String.Encoding.utf8)
                print("params: \(httpBodyString ?? "none")")
            }
            let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                defer {
                    if let url = urlRequest.url {
                        self?.tasks[url] = nil
                    }
                }
                
                if let data = data, let response = response, error == nil {
                    if let httpResponse = response as? HTTPURLResponse {
                        print(httpResponse)
                        let dispatcherResponse = DispatcherResponse(statusCode: httpResponse.statusCode, data: data, response: httpResponse)
                        completion(Result.success(dispatcherResponse))
                    } else {
                        completion(Result.failure(.unknown))
                    }
                } else if let error = error {
                    print("!@#!@# httpResponse \(error.localizedDescription)")
                    completion(Result.failure(.urlSessionError(error: error)))
                }
            }
            task.resume()
            tasks[urlRequest.url!] = task
            return URLSessionCancellable(task: task)
        } catch {
            return URLSessionCancellable(task: nil)
        }
    }
    
    private func createBody(parameters: [String: Any]?,
                            boundary: String,
                            files: [MultipartFormDataFile]) -> Data {
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        for file in files {
            let boundaryPrefix = "--\(boundary)\r\n"
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(file.uploadId)\"; filename=\"\(file.filename)\"")
            body.appendString("\r\n")
            body.appendString("Content-Type: \(file.mimeType)\r\n\r\n")
            body.append(file.data)
            body.appendString("\r\n")
        }
        body.appendString("--".appending(boundary.appending("--")))
        return body as Data
    }
    
    // Метод подготавлювающий URL с использованием параметров сформированных в Request
    
    private func prepareURLRequest(for request: Request) throws -> URLRequest {
        let urlPath = "\(request.baseURL)/\(request.path)"
        guard let url = URL(string: urlPath) else { throw NetworkError.badPath }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 20.0)
        urlRequest.httpMethod = request.method.rawValue
        
        for header in request.headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if let multipartFormData = request.multipartFormData {
            let boundary = "Boundary-\(UUID().uuidString)"
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)",
                                forHTTPHeaderField: "Content-Type")
            let body = createBody(parameters: multipartFormData.parameters, boundary: boundary,
                                  files: multipartFormData.files)
            urlRequest.setValue(String(body.count),
                                forHTTPHeaderField: "Content-Length")
            urlRequest.httpBody = body
        }
        
        switch request.parameters {
        case .body(let params):
            if let params = params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .init(rawValue: 0))
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } else {
                throw NetworkError.badInput
            }
        case .url(let params):
            if let params = params {
                guard params.count > 0 else { break }
                let queryParams = params.map({ (element) -> URLQueryItem in
                    return  URLQueryItem(name: element.key, value: "\(element.value)")
                })
                guard var components = URLComponents(string: urlPath) else {
                    throw NetworkError.badInput
                }
                components.queryItems = queryParams
                let allowedCharacterSet = (CharacterSet(charactersIn: "+").inverted)
                let urlStr = components.url?.absoluteString
                    .addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? ""
                urlRequest.url = URL(string: urlStr)
            } else {
                throw NetworkError.badInput
            }
        }
        return urlRequest
    }
    
    private func createQueryParamsFrom(params: [String: Any]?) throws -> [URLQueryItem] {
        if let params = params {
            let queryParams = params.map({ (element) -> URLQueryItem in
                return URLQueryItem(name: element.key, value: "\(element.value)")
            })
            return queryParams
        } else {
            throw NetworkError.badInput
        }
    }
    
    deinit {
        print("Deinit Network Dispatch")
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
