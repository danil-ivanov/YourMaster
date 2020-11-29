
import Foundation

// Результат выполнения запроса, может быть завершен успешно success(T)
// и содержать полученный параметр, либо
// в случае неудачи содержит ошибку failure(Error)

public enum NetworkResult {
    case success(Data, URLResponse, Error?)
    case failure(Data?, URLResponse?, Error)
    
    public var error: Error? {
        switch self {
        case .success(_):
            return nil
        case let .failure(_, _, error):
            return error
        }
    }
    
    public var value: Data? {
        switch self {
        case let .success(data, _, _):
            return data
        case let .failure(data, _, _):
            return data
        }
    }
}
