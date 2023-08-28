import UIKit

final class LetterViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Private properties
    private var lettersLearned: [(String, String)] = []
    private var currentIndex: Int = 0
    private var currentLetter: String = ""
    private var letterIsArmenian: Bool = true
    private var letterIsFavorite: Bool = false
    
    //MARK: - Layout elements
    private lazy var helpButton = UIBarButtonItem(
        image: UIImage(systemName: "questionmark.circle"),
        style: .plain,
        target: self,
        action: #selector(didTapHelpButton)
    )
    
    private lazy var alphabetButton = UIBarButtonItem(
        image: UIImage(systemName: "character.book.closed"),
        style: .plain,
        target: self,
        action: #selector(didTapAlphabetButton)
    )
    
    private lazy var letterCard: UIButton = {
        let letterCard = UIButton()
        letterCard.translatesAutoresizingMaskIntoConstraints = false
        letterCard.backgroundColor = .white
        letterCard.layer.borderColor = UIColor.lightGray.cgColor
        letterCard.layer.borderWidth = 1
        letterCard.layer.cornerRadius = 16
        letterCard.titleLabel?.font = .boldSystemFont(ofSize: 128)
        letterCard.titleLabel?.numberOfLines = 2
        letterCard.setTitleColor(.black, for: .normal)
        letterCard.titleLabel?.textAlignment = .center
        letterCard.addTarget(self, action: #selector(self.didTapLetterButton(sender:)), for: .touchUpInside)
        return letterCard
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = alphabetButton
        navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16)
        
        navigationItem.leftBarButtonItem = helpButton
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)
        
        addNexButton()
        addLetterCard()
        
        let letter = LetterFactory().randomLetter()
        lettersLearned.append(letter)
        currentLetter = letter.0
        if !lettersLearned.isEmpty { letterCard.setTitle(lettersLearned[0].0, for: .normal) }
        
        navigationItem.title = "\(currentIndex + 1) из \(lettersLearned.count)"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    // MARK: - Private Methods
    @objc
    private func didTapLetterButton(sender: Any) {
        flipCard(direction: .transitionFlipFromRight)
    }
    
    private func nextLetter() {
        if currentIndex == lettersLearned.count - 1 {
            let letter = LetterFactory().randomLetter()
            currentLetter = letter.0
            lettersLearned.append(letter)
        }
        currentIndex += 1
        letterIsArmenian = true
        letterCard.setTitle(lettersLearned[currentIndex].0, for: .normal)
        letterCard.titleLabel?.font = .boldSystemFont(ofSize: 128)
        UIView.transition(with: letterCard, duration: 0.5, options: .transitionCurlDown, animations: nil)
        navigationItem.title = "\(currentIndex + 1) из \(lettersLearned.count)"
    }
    
    private func previousLetter() {
        if currentIndex == 0 {
            return
        } else {
            currentIndex -= 1
        }
        currentLetter = lettersLearned[currentIndex].0
        letterIsArmenian = true
        letterCard.setTitle(lettersLearned[currentIndex].0, for: .normal)
        letterCard.titleLabel?.font = .boldSystemFont(ofSize: 128)
        UIView.transition(with: letterCard, duration: 0.5, options: .transitionCurlUp, animations: nil)
        navigationItem.title = "\(currentIndex + 1) из \(lettersLearned.count)"
    }
    
    private func flipCard(direction: UIView.AnimationOptions) {
        if letterIsArmenian {
            letterCard.setTitle(lettersLearned[currentIndex].1, for: .normal)
            letterCard.titleLabel?.font = .systemFont(ofSize: 96)
            UIView.transition(with: letterCard, duration: 0.3, options: direction, animations: nil)
            
        } else {
            letterCard.setTitle(lettersLearned[currentIndex].0, for: .normal)
            letterCard.titleLabel?.font = .boldSystemFont(ofSize: 128)
            UIView.transition(with: letterCard, duration: 0.3, options: direction, animations: nil)
            
        }
        letterIsArmenian.toggle()
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    @objc
    private func didTapNextButton(sender: Any) {
        nextLetter()
    }
    
    @objc
    private func didTapHelpButton(sender: Any) {
        let helpVC = HelpViewController()
        helpVC.modalTransitionStyle = .crossDissolve
        helpVC.modalPresentationStyle = .overCurrentContext
        self.present(helpVC, animated: true)
    }
    
    @objc
    private func didTapAlphabetButton(sender: Any) {
        let position = LetterFactory().indexOfLetter(letter: currentLetter)
        self.present(AlphabetViewController(position: position), animated: true)
    }
    
    @objc
    private func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            previousLetter()
        }
        else if gesture.direction == .down {
            nextLetter()
        }
        else if gesture.direction == .left {
            flipCard(direction: .transitionFlipFromRight)
        }
        else if gesture.direction == .right {
            flipCard(direction: .transitionFlipFromLeft)
        }
    }
    
    // MARK: - Layout methods
    private func addLetterCard() {
        view.addSubview(letterCard)
        NSLayoutConstraint.activate([
            letterCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            letterCard.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -32),
            letterCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            letterCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func addNexButton() {
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}
