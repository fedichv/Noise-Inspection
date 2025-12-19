import Foundation

final class OnboardingPresenter {

    private weak var view: OnboardingViewProtocol?

    private let slides: [OnboardingSlide] = [
        OnboardingSlide(
            title: "Measure the sound level around you",
            description: "Precise and powerful decibel measurement",
            imageName: "City",
            textButton: "Continue",
            imagePhone: "",
            showsPhoneImage: false
        ),
        OnboardingSlide(
            title: "Evaluate the sound level using help chart",
            description: "Scientific classification of sounds",
            imageName: "",
            textButton: "Continue",
            imagePhone: "Inf",
            showsPhoneImage: true
        ),
        OnboardingSlide(
            title: "Enable access to the microphone",
            description: "This will allow measurement of noise",
            imageName: "",
            textButton: "Enable",
            imagePhone: "MikRed",
            showsPhoneImage: true
        )
    ]

    private var currentIndex = 0

    var slidesCount: Int { slides.count }

    func attachView(_ view: OnboardingViewProtocol) {
        self.view = view
        showSlide(at: 0)
    }

    func showNextSlide() {
        if currentIndex == slides.count - 1 {
            view?.onboardingCompleted()
            return
        }
        currentIndex += 1
        showSlide(at: currentIndex)
    }

    func showPreviousSlide() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        showSlide(at: currentIndex)
    }

    private func showSlide(at index: Int) {
        let slide = slides[index]
        view?.updateSlide(with: slide, at: index)
        view?.updatePageControl(currentPage: index)
    }
}
