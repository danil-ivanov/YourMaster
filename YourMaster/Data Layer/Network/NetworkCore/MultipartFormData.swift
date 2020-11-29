
import Foundation

public struct MultipartFormDataFile {
    var data: Data
    var mediaFiletype: String
    var filename: String {
        return "\(UUID().uuidString).\(mediaFiletype)"
    }
    var mimeType: String
    var uploadId: String
    
    init(data: Data, mediaFiletype: String, mimeType: String, uploadId: String) {
        self.data = data
        self.mediaFiletype = mediaFiletype
        self.mimeType = mimeType
        self.uploadId = uploadId
    }
}

public struct MultipartFormData {
    var files: [MultipartFormDataFile]
    var parameters: [String: Any]?
    var mimeType: String
    
    init(files: [MultipartFormDataFile], mimeType: String, parameters: [String: Any]? = nil) {
        self.files = files
        self.parameters = parameters
        self.mimeType = mimeType
    }
}
