import UIKit
import NeonSDK

class CustomOnboardingController: NeonOnboardingController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureButton(
            title: "Get Started",
            titleColor: .black,
            font: Font.custom(size: 18, fontWeight: .Bold),
            cornerRadious: 30,
            height: 50,
            horizontalPadding: 40,
            bottomPadding: 0,
            backgroundColor: .buttonColor,
            borderColor: nil,
            borderWidth: nil
        )
        self.configureBackground(
            type: .halfBackgroundImage(
                backgroundColor: .black,
                offset: 130,
                isFaded: true)
        )

        self.configurePageControl(
            type: .V1,
            currentPageTintColor: .white,
            tintColor: .lightGray,
            radius: 4,
            padding: 8
        )
        
        self.configureText(
            titleColor: .white,
            titleFont: Font.custom(size: 30, fontWeight: .Bold),
            subtitleColor: .white,
            subtitleFont: Font.custom(size: 18, fontWeight: .Medium)
        )
        
        self.addPage(
            title: "Introducing Image AI",
            subtitle: "Create a digital representation of yourself with AI technology",
            image: UIImage(named: "onb1")!
        )
        
        self.addPage(
            title: "Get Infinite versions of you with AI",
            subtitle: "Design your avatar with a wide range of customizable features.",
            image: UIImage(named: "onb2")!
        )
        
        self.addPage(
            title: "Turn your words to art",
            subtitle: "Generate amazing images from basic text prompts",
            image: UIImage(named: "onb3")!
        )        
        
        self.addPage(
            title: "Ready to Share",
            subtitle: "Once you’ve created your images, share them with the world on social media",
            image: UIImage(named: "onb4")!
        )
        
      
    }
    
    override func onboardingCompleted() {
        Neon.onboardingCompleted()
        self.present(destinationVC: PremiumPageViewController(), slideDirection: .up)
    }
}
