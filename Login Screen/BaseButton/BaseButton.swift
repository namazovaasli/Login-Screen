
import UIKit
import SnapKit

class BaseButton: UIButton {
    
    var buttonStyle: ButtonCases
    
    init(buttonStyle: ButtonCases) {
        self.buttonStyle = buttonStyle
        super.init(frame: .zero)
        designBase()
        changeButtonStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func changeButtonStyle() {
        switch buttonStyle{
            
        case .guest : designGuest()
            
        case .google: designGoogle ()
        case .apple : designApple()
        default:
            return
        }
    }
    
    func designGuest() {
        setTitle("Qonaq olaraq davam edin", for: .normal)
        
    }
    
    func designGoogle(){
        setTitle("Google ilə davam edin", for: .normal)
        setImage(UIImage(named: "google"), for: .normal)
        
    }
    
    func designApple(){
        setTitle("Apple ilə davam edin", for: .normal)
        setImage(UIImage(named: "apple"), for: .normal)
        
    }
    
    func designBase() {
        setTitleColor(.black, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 24
        titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(48)}
    }
}
