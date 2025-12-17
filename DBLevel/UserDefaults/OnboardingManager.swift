import Foundation

class OnboardingManager {
    static let shared = OnboardingManager()
    private let userDefaults = UserDefaults.standard
    private let hasSeenOnboardingKey = "hasSeenOnboarding"
    
    var hasSeenOnboarding: Bool {
        return userDefaults.bool(forKey: hasSeenOnboardingKey)
    }
    
    func markOnboardingAsSeen() {
        userDefaults.set(true, forKey: hasSeenOnboardingKey)
    }
    
    func resetOnboarding() {
        userDefaults.removeObject(forKey: hasSeenOnboardingKey)
    }
}
