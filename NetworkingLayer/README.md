# NetworkingLayer
===========

Making Requests
-----------

To create requests, you can then use structs or enums which inherit from **ServiceProtocol** : 

```swift
struct Request: ServiceProtocol {
    var baseURL: URL
    var path: String
    var method: HTTPMethod
    var params: JSON?
    var headers: HTTPHeaders?
}
``` 

or : 

```swift
enum Requests: ServiceProtocol {
    case requestOne
    case requestTwo(variable: String)
    
    var baseURL: URL {
        return URL(string: "your base url")!
    }
    
    var path: String {
        switch self {
        case .requestOne:
            return "request/one"
        case .requestTwo(variable: let variable):
            return "request/two/" + variable
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: JSON? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
``` 

Note: params and headers are not mandatory under ServiceProtocol but are useful for more complicated request.
