import UIKit
import NeonSDK
import Firebase
import Adapty

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Font.configureFonts(font: .Inter)
        
        FirebaseApp.configure()
        let onboardingVC = CustomOnboardingController()
        let homeVC = AIAvatarViewController()
        let paywallVC = PremiumPageViewController()
        
        AdaptyManager.configure(withAPIKey: "your-adapty-key", placementIDs: ["pro"])
        Adapty.logLevel = .verbose
        AdaptyManager.delegate = paywallVC

        
        Neon.configure(
            window: &window,
            onboardingVC: onboardingVC,
            paywallVC: paywallVC,
            homeVC: homeVC)
        
        
        
        return true
    }
    
    
}

