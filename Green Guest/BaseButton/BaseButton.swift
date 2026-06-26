
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
        case .login : designLogin ()
        case .guest : designGuest()
        case .main : designMain ()
        case .google: designGoogle ()
        case .apple : designApple()
        case .submit : designSubmit()
        case .cancel : designCancel()
        case .register : designRegister()
        }
    }
    private func designCancel() {
        setTitle("Ləğv edin", for: .normal)
        setTitleColor(.maintext, for: .normal)  //black
        backgroundColor = .white
        layer.borderColor = UIColor(named: "textfieldcolor")?.cgColor
        layer.borderWidth = 1
    }
    private func designRegister() {
        setTitle("Qeydiyyatdan keçin", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(named: "mainbuttoncolor")
    }
    
    
    private func designSubmit() {
        setTitle("Davam edin", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(named: "mainbuttoncolor")
    }
    
    private func designMain() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(named: "mainbuttoncolor")
    }
    
    private func designLogin() {
        setTitle("Daxil olun", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(named: "mainbuttoncolor")
    }
    
   private func designGuest() {
        setTitle("Qonaq olaraq davam edin", for: .normal)
        
    }
    
    private func designGoogle(){
        setTitle("Google ilə davam edin", for: .normal)
        setImage(UIImage(named: "google"), for: .normal)
        
    }
    
    private func designApple(){
        setTitle("Apple ilə davam edin", for: .normal)
        setImage(UIImage(named: "apple"), for: .normal)
        
    }
    
    private func designBase() {
        setTitleColor(.black, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 32
        titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(56)}
    }
}
