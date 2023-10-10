
import Foundation

class ViewModel {
    
    let networkService: NetworkService
    
    private var characters: [Result] = []
    
    init() {
        self.networkService = NetworkService()
    }
    
    func fetchCharacters(completion: @escaping ([Result]) -> Void) {
        networkService.requestCharacters { characters in
            completion(characters)
        }
    }
    
}
