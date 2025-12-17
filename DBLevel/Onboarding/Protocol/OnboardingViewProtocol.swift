import Foundation

protocol OnboardingViewProtocol: AnyObject {
    func updateSlide(with slide: OnboardingSlide, at index: Int)
    func updatePageControl(currentPage: Int)
    func onboardingCompleted()
}
