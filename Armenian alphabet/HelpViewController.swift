import UIKit

final class HelpViewController: UIViewController {
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Инструкция"
        headerLabel.font = .boldSystemFont(ofSize: 16)
        headerLabel.textColor = .black
        return headerLabel
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
    
    private lazy var helpTextView: UITextView = {
        let helpTextView = UITextView()
        helpTextView.translatesAutoresizingMaskIntoConstraints = false
        helpTextView.font = .systemFont(ofSize: 17)
        helpTextView.textColor = .black
        helpTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 11, right: 16)
        helpTextView.backgroundColor = .white
        helpTextView.layer.cornerRadius = 12
        helpTextView.layer.masksToBounds = true
        helpTextView.text = """
Следующая буква - свайп вниз

Предыдущая буква - свайп вверх

Перевернуть карточку - свайп влево/вправо или тап

Посмотреть весь алфавит - кнопка вверху справа
"""
        return helpTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addHeaderLabel()
        addCloseButton()
        addHelpTextView()
    }
    
    private func addHeaderLabel() {
        view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
    
    private func addHelpTextView() {
        view.addSubview(helpTextView)
        NSLayoutConstraint.activate([
            helpTextView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            helpTextView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -16),
            helpTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            helpTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func didTapCloseButton(sender: Any) {
        self.dismiss(animated: true)
    }
    
}
