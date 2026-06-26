
import Foundation

struct ValidationManager {
    static func isValidNameOrSurname(_ text: String) -> Bool {
        let regex = "^[a-zA-ZçÇğĞıİöÖşŞüÜəƏ‘' ]{2,30}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    static func isValidPhone(_ phone: String) -> Bool {
        let cleanPhone = phone.replacingOccurrences(of: " ", with: "")
                              .replacingOccurrences(of: "-", with: "")
        let regex = "^(50|51|55|70|77|99|10|60)[0-9]{7}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: cleanPhone)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d\\W_]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
}
