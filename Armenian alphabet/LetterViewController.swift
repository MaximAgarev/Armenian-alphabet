import UIKit

final class LetterViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var currentLetter = LetterFactory().randomLetter()
    private var letterIsArmenian: Bool = true
    
    private lazy var alphabetButton = UIBarButtonItem(
        image: UIImage(systemName: "character.book.closed"),
        style: .plain,
        target: self,
        action: #selector(didTapAlphabetButton)
    )
    
    private lazy var letterButton: UIButton = {
        let letterButton = UIButton()
        letterButton.translatesAutoresizingMaskIntoConstraints = false
        letterButton.backgroundColor = .white
        letterButton.layer.borderColor = UIColor.lightGray.cgColor
        letterButton.layer.borderWidth = 1
        letterButton.layer.cornerRadius = 16
        letterButton.titleLabel?.font = .boldSystemFont(ofSize: 256)
        letterButton.titleLabel?.numberOfLines = 2
        letterButton.setTitleColor(.black, for: .normal)
        letterButton.titleLabel?.textAlignment = .center
        letterButton.addTarget(self, action: #selector(self.didTapLetterButton(sender:)), for: .touchUpInside)
        return letterButton
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .systemBlue
        nextButton.layer.cornerRadius = 16
        nextButton.titleLabel?.font = .systemFont(ofSize: 14)
        nextButton.setTitle("Следующая", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.textAlignment = .center
        nextButton.addTarget(self, action: #selector(self.didTapNextButton(sender:)), for: .touchUpInside)
        return nextButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = alphabetButton
        navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16)
        
        addNexButton()
        addLetterButton()
        
        letterButton.setTitle(currentLetter.0, for: .normal)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func addLetterButton() {
        view.addSubview(letterButton)
        NSLayoutConstraint.activate([
            letterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            letterButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -32),
            letterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            letterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        }
    
    func addNexButton() {
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        }
    
    @objc
    private func didTapLetterButton(sender: Any) {
        if letterIsArmenian {
            letterButton.setTitle(currentLetter.1, for: .normal)
            letterButton.titleLabel?.font = .systemFont(ofSize: 96)
            UIView.transition(with: letterButton, duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            
        } else {
            letterButton.setTitle(currentLetter.0, for: .normal)
            letterButton.titleLabel?.font = .boldSystemFont(ofSize: 128)
            UIView.transition(with: letterButton, duration: 0.3, options: .transitionFlipFromRight, animations: nil)

        }
        letterIsArmenian.toggle()
    }
    
    @objc
    private func didTapNextButton(sender: Any) {
        currentLetter = LetterFactory().randomLetter()
        letterIsArmenian = true
        letterButton.setTitle(currentLetter.0, for: .normal)
        letterButton.titleLabel?.font = .boldSystemFont(ofSize: 128)
        UIView.transition(with: letterButton, duration: 0.7, options: .transitionCurlDown, animations: nil)
    }
    
    @objc
    private func didTapAlphabetButton(sender: Any) {
        
    }
}
