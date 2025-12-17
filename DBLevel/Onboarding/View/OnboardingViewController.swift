import UIKit
import AVFAudio

class OnboardingViewController: UIViewController {
    
    private let mainImageGradient = CAGradientLayer()
    private let phoneImageGradient = CAGradientLayer()
    private let presenter = OnboardingPresenter()
    
    private let imageOnboarding: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "City")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imagePhoneOnboarding: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewForImageAndText: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.text = "MEASURE THE SOUND LEVEL AROUND YOU"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Precise and powerful decibel measurement"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .pincExtColor
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    var onCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .black
        
        setupView()
        setupConstraints()
        setupGradient()
        
        presenter.attachView(self)

        pageControl.numberOfPages = presenter.slidesCount
        setupGestures()

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
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    
    private func setupGradient() {
        let startColor = UIColor(red: 31/255, green: 30/255, blue: 33/255, alpha: 0)
        let endColor = UIColor.black.withAlphaComponent(1)

        mainImageGradient.colors = [startColor.cgColor, endColor.cgColor]
        mainImageGradient.startPoint = CGPoint(x: 0.5, y: 0)
        mainImageGradient.endPoint   = CGPoint(x: 0.5, y: 1)
        imageOnboarding.layer.addSublayer(mainImageGradient)

        phoneImageGradient.colors = [startColor.cgColor, endColor.cgColor]
        phoneImageGradient.startPoint = CGPoint(x: 0.5, y: 0)
        phoneImageGradient.endPoint   = CGPoint(x: 0.5, y: 1)
        imagePhoneOnboarding.layer.addSublayer(phoneImageGradient)
    }
    
    func setupView() {
        view.addSubview(viewForImageAndText)
        view.addSubview(continueButton)
        view.addSubview(pageControl)
        view.addSubview(imagePhoneOnboarding)
        
        textContainerView.addSubview(titleText)
        textContainerView.addSubview(descriptionTitle)
        
        viewForImageAndText.addSubview(imageOnboarding)
        viewForImageAndText.addSubview(textContainerView)
    }
    
    @objc private func didTapContinue() {
        if presenter.isLastSlide {
            showMicrophoneAlert()
        } else {
            presenter.showNextSlide()
        }
    }
    
    private func showMicrophoneAlert() {
        let alert = UIAlertController(
            title: "Microphone Access",
            message: "We need access to your microphone to measure sound levels. Allow access?",
            preferredStyle: .alert
        )
        
        let allowAction = UIAlertAction(title: "Allow", style: .default) { [weak self] _ in
            self?.onboardingCompleted()
        }
        
        let denyAction = UIAlertAction(title: "Don't Allow", style: .cancel) { [weak self] _ in
            self?.onboardingUnCompleted()
        }
        
        alert.addAction(allowAction)
        alert.addAction(denyAction)
        
        present(alert, animated: true)
    }
    
    private func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                self?.onboardingCompleted()
            }
        }
    }
    
    private func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            presenter.showNextSlide()
        case .right:
            presenter.showPreviousSlide()
        default:
            break
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewForImageAndText.topAnchor.constraint(equalTo: view.topAnchor),
            viewForImageAndText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewForImageAndText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewForImageAndText.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -81),

            imageOnboarding.topAnchor.constraint(equalTo: viewForImageAndText.topAnchor),
            imageOnboarding.leadingAnchor.constraint(equalTo: viewForImageAndText.leadingAnchor),
            imageOnboarding.trailingAnchor.constraint(equalTo: viewForImageAndText.trailingAnchor),
            imageOnboarding.bottomAnchor.constraint(equalTo: textContainerView.topAnchor),
            
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
            
            continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -35),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    func onboardingCompleted() {
        let nextVC = UseMicroViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    func onboardingUnCompleted() {
        let nextVC = MainViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
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
}
