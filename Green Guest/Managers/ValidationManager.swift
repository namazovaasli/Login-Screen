import Foundation

struct ValidationManager {
    
    static func isValidNameOrSurname(_ text: String) -> Bool {
        let regex = "^[a-zA-ZçÇğĞıİöÖşŞüÜəƏ'' ]{2,30}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let regex = "^[A-Za-zçÇğĞıİöÖşŞüÜəƏ0-9._%+\\-]+@[A-Za-z0-9.\\-]+\\.[A-Za-z]{2,}$"
        guard NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email) else {
            return false
        }
        
        let parts = email.split(separator: "@", maxSplits: 1)
        guard parts.count == 2,
              !parts[0].isEmpty,
              !parts[1].isEmpty else { return false }
        
        let domain = String(parts[1]).lowercased()
        let domainParts = domain.split(separator: ".")
        guard domainParts.count >= 2,
              domainParts.allSatisfy({ !$0.isEmpty }) else { return false }
        
        let knownDomains: Set<String> = [
            "gmail.com", "googlemail.com",
            "yahoo.com", "yahoo.co.uk", "yahoo.fr", "yahoo.de",
            "outlook.com", "hotmail.com", "hotmail.co.uk", "live.com",
            "icloud.com", "me.com", "mac.com",
            "mail.com", "mail.ru", "mail.az",
            "protonmail.com", "proton.me",
            "aol.com",
            "yandex.com", "yandex.ru",
            "inbox.ru", "list.ru", "bk.ru",
            "box.az", "azmail.az", "diplomat.az"
        ]
        
        let validTLDs: Set<String> = [
            "com", "net", "org", "edu", "gov", "mil", "int",
            "biz", "info", "io", "co", "ai", "app", "dev",
            "tech", "online", "site", "pro", "me", "tv",
            "az", "ru", "uk", "de", "fr", "it", "es", "tr",
            "ua", "us", "ca", "au", "jp", "cn", "in", "br",
            "nl", "pl", "se", "no", "fi", "dk", "be", "ch",
            "at", "cz", "hu", "ro", "bg", "hr", "sk", "si",
            "ge", "kz", "uz", "tm"
        ]
        
        let validDoubleTLDs: Set<String> = [
            "co.uk", "co.az",
            "com.az", "net.az", "org.az", "edu.az", "gov.az", "mil.az",
            "com.tr", "com.ru", "com.br",
            "co.jp", "co.in", "co.nz"
        ]
        
        if knownDomains.contains(domain) { return true }
        
        if domainParts.count >= 3 {
            let doubleTLD = domainParts.suffix(2).joined(separator: ".")
            if validDoubleTLDs.contains(doubleTLD) { return true }
        }
        
        if let tld = domainParts.last {
            return validTLDs.contains(String(tld))
        }
        
        return false
    }
    
    static func isValidPhone(_ phone: String) -> Bool {
        let cleanPhone = phone
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
        let regex = "^(50|51|55|70|77|99|10|60)[0-9]{7}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: cleanPhone)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let hasUppercase = password.contains(where: { $0.isUppercase })
        let hasLowercase = password.contains(where: { $0.isLowercase })
        let hasDigit     = password.contains(where: { $0.isNumber })
        let hasSpecial   = password.contains(where: { !$0.isLetter && !$0.isNumber })
        let hasMinLength = password.count >= 8
        
        return hasUppercase && hasLowercase && hasDigit && hasSpecial && hasMinLength
    }
}
