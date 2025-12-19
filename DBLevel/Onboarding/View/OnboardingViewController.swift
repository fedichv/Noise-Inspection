import UIKit
import AVFAudio

final class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter = OnboardingPresenter()
    private let mainImageGradient = CAGradientLayer()
    private let phoneImageGradient = CAGradientLayer()
    
    // MARK: - UI
    
    private let viewForImageAndText: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageOnboarding: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imagePhoneOnboarding: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .pincExtColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .white
        pc.pageIndicatorTintColor = .gray
        pc.isUserInteractionEnabled = false
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupView()
        setupConstraints()
        setupGradient()
        setupGestures()
        
        presenter.attachView(self)
        pageControl.numberOfPages = presenter.slidesCount
        
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainImageGradient.frame = CGRect(
            x: 0,
            y: imageOnboarding.bounds.height * 0.7,
            width: imageOnboarding.bounds.width,
            height: imageOnboarding.bounds.height * 0.3
        )
        
        phoneImageGradient.frame = CGRect(
            x: 0,
            y: imagePhoneOnboarding.bounds.height * 0.7,
            width: imagePhoneOnboarding.bounds.width,
            height: imagePhoneOnboarding.bounds.height * 0.3
        )
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.addSubview(viewForImageAndText)
        view.addSubview(continueButton)
        view.addSubview(pageControl)
        
        viewForImageAndText.addSubview(imageOnboarding)
        viewForImageAndText.addSubview(imagePhoneOnboarding)
        viewForImageAndText.addSubview(textContainerView)
        
        textContainerView.addSubview(titleText)
        textContainerView.addSubview(descriptionTitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewForImageAndText.topAnchor.constraint(equalTo: view.topAnchor),
            viewForImageAndText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewForImageAndText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewForImageAndText.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -80),
            
            imageOnboarding.topAnchor.constraint(equalTo: viewForImageAndText.topAnchor),
            imageOnboarding.leadingAnchor.constraint(equalTo: viewForImageAndText.leadingAnchor),
            imageOnboarding.trailingAnchor.constraint(equalTo: viewForImageAndText.trailingAnchor),
            imageOnboarding.bottomAnchor.constraint(equalTo: textContainerView.topAnchor),
            
            imagePhoneOnboarding.topAnchor.constraint(equalTo: viewForImageAndText.topAnchor, constant: 97),
            imagePhoneOnboarding.leadingAnchor.constraint(equalTo: viewForImageAndText.leadingAnchor, constant: 70),
            imagePhoneOnboarding.trailingAnchor.constraint(equalTo: viewForImageAndText.trailingAnchor, constant: -70),
            imagePhoneOnboarding.bottomAnchor.constraint(equalTo: textContainerView.topAnchor),
            
            textContainerView.leadingAnchor.constraint(equalTo: viewForImageAndText.leadingAnchor),
            textContainerView.trailingAnchor.constraint(equalTo: viewForImageAndText.trailingAnchor),
            textContainerView.bottomAnchor.constraint(equalTo: viewForImageAndText.bottomAnchor),
            textContainerView.heightAnchor.constraint(equalToConstant: 120),
            
            titleText.topAnchor.constraint(equalTo: textContainerView.topAnchor),
            titleText.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: 16),
            titleText.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -16),
            
            descriptionTitle.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 12),
            descriptionTitle.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
            descriptionTitle.trailingAnchor.constraint(equalTo: titleText.trailingAnchor),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupGradient() {
        let startColor = UIColor.black.withAlphaComponent(0)
        let endColor = UIColor.black.withAlphaComponent(1)
        
        mainImageGradient.colors = [startColor.cgColor, endColor.cgColor]
        mainImageGradient.startPoint = CGPoint(x: 0.5, y: 0)
        mainImageGradient.endPoint = CGPoint(x: 0.5, y: 1)
        imageOnboarding.layer.addSublayer(mainImageGradient)
        
        phoneImageGradient.colors = [startColor.cgColor, endColor.cgColor]
        phoneImageGradient.startPoint = CGPoint(x: 0.5, y: 0)
        phoneImageGradient.endPoint = CGPoint(x: 0.5, y: 1)
        imagePhoneOnboarding.layer.addSublayer(phoneImageGradient)
    }
    
    private func setupGestures() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        left.direction = .left
        view.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        right.direction = .right
        view.addGestureRecognizer(right)
    }
    
    // MARK: - Actions
    
    @objc private func didTapContinue() {
        presenter.showNextSlide()
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        gesture.direction == .left
        ? presenter.showNextSlide()
        : presenter.showPreviousSlide()
    }
}

extension OnboardingViewController: OnboardingViewProtocol {
    
    func updateSlide(with slide: OnboardingSlide, at index: Int) {
        imageOnboarding.image = UIImage(named: slide.imageName)
        titleText.text = slide.title
        descriptionTitle.text = slide.description
        continueButton.setTitle(slide.textButton, for: .normal)
        
        imagePhoneOnboarding.isHidden = !slide.showsPhoneImage
        imagePhoneOnboarding.image = UIImage(named: slide.imagePhone)
    }
    
    func updatePageControl(currentPage: Int) {
        pageControl.currentPage = currentPage
    }
    
    func onboardingCompleted() {
        OnboardingManager.shared.markOnboardingAsSeen()
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
