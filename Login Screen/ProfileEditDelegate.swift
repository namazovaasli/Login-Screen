//
//  ProfileEditDelegate.swift
//  Login Screen
//
//  Created by Əsli Namazova on 26.06.26.
//

import UIKit
import SnapKit

protocol ProfileEditDelegate: AnyObject {
    func didUpdateProfile(username: String, email: String, phone: String)
}
