
import Foundation

// Этот протокол описывает основную структуру запроса

public protocol Request {
    
    // Основная ссылка, по которой располагается ресурс
    
    var baseURL: String { get }
    
    // URL путь к ресурсу
    
    var path: String { get }
    
    // Метод запроса к серверу
    
    var method: HTTPMethod { get }
    
    // Способ передачи параметров серверу
    
    var parameters: RequestParameters { get }
    
    var multipartFormData: MultipartFormData? { get }
    
    var headers: [String: String] { get }
}

extension Request {
    var multipartFormData: MultipartFormData? { return nil }
    var baseURL: String { return AppConfiguration.serverUrl}
    var headers: [String: String] { [:] }
}

extension Request {
    var id: String { return UUID().uuidString }
}
