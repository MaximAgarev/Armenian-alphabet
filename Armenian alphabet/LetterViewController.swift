import UIKit

final class LetterViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var lettersLearned: [(String, String)] = []
    private var currentIndex: Int = 0
    private var letterIsArmenian: Bool = true
    private var letterIsFavorite: Bool = false
    
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
    
    private lazy var letterButton: UIButton = {
        let letterButton = UIButton()
        letterButton.translatesAutoresizingMaskIntoConstraints = false
        letterButton.backgroundColor = .white
        letterButton.layer.borderColor = UIColor.lightGray.cgColor
        letterButton.layer.borderWidth = 1
        letterButton.layer.cornerRadius = 16
        letterButton.titleLabel?.font = .boldSystemFont(ofSize: 128)
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
    
    private lazy var favoritesButton: UIButton = {
       let favoritesButton = UIButton()
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoritesButton.tintColor = .systemOrange
        favoritesButton.addTarget(self, action: #selector(self.didTapFavoriteButton(sender:)), for: .touchUpInside)
        return favoritesButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = alphabetButton
        navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16)
        
        navigationItem.leftBarButtonItem = helpButton
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)
        
        addNexButton()
        addFavoritesButton()
        addLetterButton()
        
        lettersLearned.append(LetterFactory().randomLetter())
        if !lettersLearned.isEmpty { letterButton.setTitle(lettersLearned[0].0, for: .normal) }
        
        navigationItem.title = "\(currentIndex + 1) из \(lettersLearned.count)"
        
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
    
    private func addLetterButton() {
        view.addSubview(letterButton)
        NSLayoutConstraint.activate([
            letterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            letterButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -32),
            letterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            letterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func addNexButton() {
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -132)
        ])
    }
    
    private func addFavoritesButton() {
        view.addSubview(favoritesButton)
        NSLayoutConstraint.activate([
            favoritesButton.heightAnchor.constraint(equalToConstant: 48),
            favoritesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            favoritesButton.widthAnchor.constraint(equalToConstant: 48),
            favoritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    @objc
    private func didTapLetterButton(sender: Any) {
        flipCard(direction: .transitionFlipFromRight)
    }
    
    private func nextLetter() {
        if currentIndex == lettersLearned.count - 1 {
            lettersLearned.append(LetterFactory().randomLetter())
        }
        currentIndex += 1
        letterIsArmenian = true
        letterButton.setTitle(lettersLearned[currentIndex].0, for: .normal)
        letterButton.titleLabel?.font = .boldSystemFont(ofSize: 128)
        UIView.transition(with: letterButton, duration: 0.5, options: .transitionCurlDown, animations: nil)
        navigationItem.title = "\(currentIndex + 1) из \(lettersLearned.count)"
    }
    
    private func previousLetter() {
        if currentIndex == 0 {
            return
        } else {
            currentIndex -= 1
        }
        letterIsArmenian = true
        letterButton.setTitle(lettersLearned[currentIndex].0, for: .normal)
        letterButton.titleLabel?.font = .boldSystemFont(ofSize: 128)
        UIView.transition(with: letterButton, duration: 0.5, options: .transitionCurlUp, animations: nil)
        navigationItem.title = "\(currentIndex + 1) из \(lettersLearned.count)"
    }
    
    private func flipCard(direction: UIView.AnimationOptions) {
        if letterIsArmenian {
            letterButton.setTitle(lettersLearned[currentIndex].1, for: .normal)
            letterButton.titleLabel?.font = .systemFont(ofSize: 96)
            UIView.transition(with: letterButton, duration: 0.3, options: direction, animations: nil)
            
        } else {
            letterButton.setTitle(lettersLearned[currentIndex].0, for: .normal)
            letterButton.titleLabel?.font = .boldSystemFont(ofSize: 128)
            UIView.transition(with: letterButton, duration: 0.3, options: direction, animations: nil)
            
        }
        letterIsArmenian.toggle()
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    @objc
    private func didTapNextButton(sender: Any) {
        nextLetter()
    }
    
    @objc
    private func didTapFavoriteButton(sender: Any) {
        letterIsFavorite.toggle()
        let imageName = self.letterIsFavorite ? "star.fill" : "star"
        guard let image = UIImage(systemName: imageName) else { return }
        let buttonImage = resizedImage(image: image, for: CGSize(width: 30, height: 25))
        favoritesButton.setImage(buttonImage, for: .normal)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    @objc
    private func didTapHelpButton(sender: Any) {
        self.present(HelpViewController(), animated: true)
    }
    
    @objc
    private func didTapAlphabetButton(sender: Any) {
        self.present(AlphabetViewController(), animated: true)
    }
    
    @objc
    func handleGesture(gesture: UISwipeGestureRecognizer) {
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
}

extension LetterViewController {
    func resizedImage(image: UIImage, for size: CGSize) -> UIImage? {

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
