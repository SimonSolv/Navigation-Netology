import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        switch configuration {
        case .first:
            let address = "https://swapi.dev/api/people/8"
            requestSession(address: address)
        case .second:
            let address = "https://swapi.dev/api/starships/3"
            requestSession(address: address)
        case .third:
            let address = "https://swapi.dev/api/planets/5"
            requestSession(address: address)
        }
    }
}

enum AppConfiguration: String, CaseIterable {
    case first
    case second
    case third
}

func requestSession(address: String) {
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: URL(string: address)!, completionHandler: { data, responce, error in
        if let error = error {
            print("Connection error:\n")
            print(error.localizedDescription)
            return
        }

        if (responce as! HTTPURLResponse).statusCode != 200 {
            print ("StstusCode = \((responce as! HTTPURLResponse).statusCode)")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            let answer = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            guard let myanswer = answer else { print("No Values in dict")
                return
            }
            let printAnswer = myanswer.reversed()
            printAnswer.forEach { print("\($0): \($1)") }
        } catch {
            print (error)
        }
        print ("StstusCode = \((responce as! HTTPURLResponse).statusCode)")
        print ("AllHeaderFields = \((responce as! HTTPURLResponse).allHeaderFields)")
        
    })
    task.resume()
}
