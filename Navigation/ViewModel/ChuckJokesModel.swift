import Foundation

func getRandomJoke(completion: ((_ joke: String?) -> Void)?) {
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: URL(string: "https://api.chucknorris.io/jokes/random")!, completionHandler: { data, responce, error in
        if let error = error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }
        
        if (responce as! HTTPURLResponse).statusCode != 200 {
            print ("StstusCode = \((responce as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }
        
        guard let data = data else {
            print("No data received")
            completion?(nil)
            return
        }
        
        do {
            let answer = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            if let joke = answer?["value"] as? String {
                completion?(joke)
                return
            }
        } catch {
            print (error)
        }
        completion?(nil)
    })
    task.resume()
}

func getJokeList(searchString string: String, completion: ((_ jokeArray: [String]? ) -> Void)?) {
    let urlString = "https://api.chucknorris.io/jokes/search?query=\(string)"
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: URL(string: urlString)!, completionHandler: { data, responce, error in
        if let error = error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }
        
        if (responce as! HTTPURLResponse).statusCode != 200 {
            print ("StstusCode = \((responce as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }
        
        guard let data = data else {
            print("No data received")
            completion?(nil)
            return
        }
        
        do {
            let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let arrayDict = (answer?["result"] as? [[String: Any]]) ?? []
            
            var returnArray: [String] = []
            for dict in arrayDict {
                if let joke = dict["value"] as? String {
                    returnArray.append(joke)
                }
            }
            completion?(returnArray)
            
            return
        } catch {
            print(error)
        }
        
        completion?(nil)
    })
    task.resume()
}
