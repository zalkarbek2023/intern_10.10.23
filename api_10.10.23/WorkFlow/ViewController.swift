

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(CustomCharactersTableViewCell.self, forCellReuseIdentifier: CustomCharactersTableViewCell.reuseID)
        return view
    }()
    
    private let viewModel: ViewModel
    
    private var characters: [Result] = []
    var likedCharacters: [Result] = [] {
        didSet {
            let data = try! JSONEncoder().encode(likedCharacters)
            UserDefaults.standard.set(data, forKey: "qwerty")
        }
    }
    private var filteredCharacters: [Result] = []
    private var isFiltered: Bool = false
    
    init() {
        viewModel = ViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = ViewModel()
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        fetch()
    }

    func setUp() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetch() {
        viewModel.fetchCharacters { chars in
            self.characters = chars
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltered ? filteredCharacters.count : characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCharactersTableViewCell.reuseID, for: indexPath) as! CustomCharactersTableViewCell
        let model = isFiltered ? filteredCharacters[indexPath.row] : characters[indexPath.row]
        cell.config(character: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailsViewController()
//        vc.delegate = self
//        vc.config(character: characters[indexPath.row])
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

