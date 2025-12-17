import UIKit

class UseMicroViewController: UIViewController {
    
    private let phoneImageGradient = CAGradientLayer()
    
    private let imagePhoneOnboarding: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "MikGreen")
        return imageView
    }()
    
    private let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewForImageAndText: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.text = "APP NAME IS READY TO USE"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Everything is ready to measure the sound level"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupView()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradient()
    }
    
    private func setupGradient() {
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        
        phoneImageGradient.colors = [startColor, endColor]
        phoneImageGradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        phoneImageGradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        phoneImageGradient.locations = [0, 1]
    }
    
    private func setupView() {
        view.addSubview(viewForImageAndText)
        view.addSubview(continueButton)
        
        textContainerView.addSubview(titleText)
        textContainerView.addSubview(descriptionTitle)
        
        viewForImageAndText.addSubview(imagePhoneOnboarding)
        viewForImageAndText.addSubview(textContainerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewForImageAndText.topAnchor.constraint(equalTo: view.topAnchor),
            viewForImageAndText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewForImageAndText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewForImageAndText.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -81),
            
            imagePhoneOnboarding.topAnchor.constraint(equalTo: viewForImageAndText.topAnchor, constant: 110),
            imagePhoneOnboarding.leadingAnchor.constraint(equalTo: viewForImageAndText.leadingAnchor, constant: 50),
            imagePhoneOnboarding.trailingAnchor.constraint(equalTo: viewForImageAndText.trailingAnchor, constant: -50),
            imagePhoneOnboarding.bottomAnchor.constraint(equalTo: textContainerView.topAnchor),
            
            textContainerView.leadingAnchor.constraint(equalTo: viewForImageAndText.leadingAnchor),
            textContainerView.trailingAnchor.constraint(equalTo: viewForImageAndText.trailingAnchor),
            textContainerView.heightAnchor.constraint(equalToConstant: 116),
            textContainerView.bottomAnchor.constraint(equalTo: viewForImageAndText.bottomAnchor),
            
            titleText.topAnchor.constraint(equalTo: textContainerView.topAnchor),
            titleText.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: 16),
            titleText.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -16),
            
            descriptionTitle.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 12),
            descriptionTitle.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: 16),
            descriptionTitle.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -16),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -47)
        ])
    }
}
