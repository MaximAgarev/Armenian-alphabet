import UIKit

final class HelpViewController: UIViewController {
    
    //MARK: - Layout elements
    private lazy var onboardingImage: UIImageView = {
        let onboardingImage = UIImageView()
        onboardingImage.translatesAutoresizingMaskIntoConstraints = false
        onboardingImage.image = UIImage(named: "onboardingImage")
        onboardingImage.layer.opacity = 0.9
        onboardingImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        onboardingImage.addGestureRecognizer(tapRecognizer)
        return onboardingImage
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = .clear
        
        addOnboardingImage()
    }
    
    // MARK: - Private Methods
    @objc
    private func imageTapped(sender: UIImageView) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Layout Methods
    private func addOnboardingImage() {
        view.addSubview(onboardingImage)
        NSLayoutConstraint.activate([
            onboardingImage.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            onboardingImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
