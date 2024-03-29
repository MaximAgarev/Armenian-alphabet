import UIKit

final class AlphabetViewController: UIViewController {
    
    //MARK: - Private properties
    private var position: Int?
    
    //MARK: - Layout elements
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "Алфавит"
        headerLabel.font = .boldSystemFont(ofSize: 16)
        headerLabel.textColor = .black
        return headerLabel
    }()
    
    private lazy var alphabetTable: UITableView = {
        let alphabetTable = UITableView()
        alphabetTable.translatesAutoresizingMaskIntoConstraints = false
        alphabetTable.layer.cornerRadius = 16
        alphabetTable.layer.masksToBounds = true
        alphabetTable.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        alphabetTable.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        alphabetTable.allowsMultipleSelection = false
        alphabetTable.dataSource = self
        alphabetTable.delegate = self
        return alphabetTable
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 16
        closeButton.layer.borderColor = UIColor.systemBlue.cgColor
        closeButton.layer.borderWidth = 1
        closeButton.titleLabel?.font = .systemFont(ofSize: 14)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.titleLabel?.textAlignment = .center
        closeButton.addTarget(self, action: #selector(self.didTapCloseButton(sender:)), for: .touchUpInside)
        return closeButton
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addHeaderLabel()
        addCloseButton()
        addAlphabetTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let position = position {
            alphabetTable.selectRow(at: [0, position], animated: true, scrollPosition: .middle)
            alphabetTable.scrollToRow(at: [0, position], at: .middle, animated: true)
        }
    }
    
    init(position: Int?) {
        super.init(nibName: nil, bundle: nil)
        self.position = position
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    @objc
    private func didTapCloseButton(sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Layout Methods
    private func addHeaderLabel() {
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func addAlphabetTable() {
        view.addSubview(alphabetTable)
        NSLayoutConstraint.activate([
            alphabetTable.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            alphabetTable.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -16),
            alphabetTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alphabetTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ])
    }
    
    private func addCloseButton() {
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 48),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - Extensions
extension AlphabetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LetterFactory().count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath as IndexPath)
        let capital = LetterFactory().letterByIndex(index: indexPath.row)[0]
        let small = LetterFactory().letterByIndex(index: indexPath.row)[1]
        let russian = LetterFactory().letterByIndex(index: indexPath.row)[2]
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = "\(capital), \(small) -- [\(russian)]"
        cell.textLabel?.highlightedTextColor = .white
        
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.tintColor = .cyan
        cell.selectedBackgroundView = view
        
        return cell
    }
}

extension AlphabetViewController: UITableViewDelegate {
    
}
 
