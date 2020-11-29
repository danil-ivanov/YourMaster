
struct Storage {
    private let defaultsWrapper: UserDefaultsWrapperProtocol
    
    var authorized: Bool {
        if let _ = try? defaultsWrapper.getToken()  {
            return true
        }
        return false
    }
    
    var token: String? {
        try? defaultsWrapper.getToken()
    }
    
    var user: User? {
        try? defaultsWrapper.getUser()
    }
    
    init(defaultsWrapper: UserDefaultsWrapperProtocol) {
        self.defaultsWrapper = defaultsWrapper
    }
    
    func update(token: String) {
        defaultsWrapper.updateToken(token: token)
    }
    
    func update(user: User) {
        defaultsWrapper.update(user: user)
    }
}
