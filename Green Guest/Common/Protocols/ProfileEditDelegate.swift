

import Foundation

protocol ProfileEditDelegate: AnyObject {
    func didUpdateProfile(email: String, phone: String)
}

