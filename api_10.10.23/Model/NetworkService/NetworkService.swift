
import Foundation

class NetworkService {
    
    func requestCharacters(completion: @escaping ([Result]) -> Void) {
        let request = URLRequest(url: Constants.API.baseURL)
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(Characters.self, from: data)
                completion(model.results)
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func getImage(url: String) -> Data {
        guard let data = ImageDownloader(
            urlString: url
        ).donwload()
        else { return Data() }
        return data
    }
}
struct ImageDownloader {
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func donwload() -> Data? {
        guard let data = try? Data(
            contentsOf: URL(string: urlString)!
        ) else {
            return nil
        }
        
        return data
    }
}
