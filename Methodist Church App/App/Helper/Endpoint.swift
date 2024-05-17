//
//  Endpoint.swift
//  MethodistMobile
//
//  Created by Q002 on 18/02/2024.
//

import Foundation

class Endpoint {
    static let baseURL = "https://methodist.azurewebsites.net"
    static let mcrpapiBaseURL = "https://mcrpapi-dev.azurewebsites.net"
    static let authpoint = "\(baseURL)/api"
    static let mcrpapiAuthpoint = mcrpapiBaseURL
    static let baseAuth = "\(authpoint)/auth"
    static let mcrpapiBaseAuth = "\(mcrpapiAuthpoint)/auth"
    static let mcrpapiBaseAccount = "\(mcrpapiAuthpoint)/accounts"
    static let populateAll = "?populate=*"
    static var news: String { return "\(authpoint)/news\(populateAll)" }
    static let churches = "\(mcrpapiBaseURL)/churches"
    static let memberType = "\(mcrpapiBaseURL)/member-types"
    static let churchClass = "\(mcrpapiBaseURL)/church-classes"
    static let classAttendance = "\(mcrpapiBaseURL)/class-attendance"
    static let members = "\(mcrpapiBaseURL)/members"
    static let memberByClass = "\(members)/by-class"
    static let classAttendanceBySociety = "\(mcrpapiBaseURL)/class-attendance/by-society"
    static let societyAnnouncement = "\(mcrpapiBaseURL)/announcements/all-published-active"
    static let systemOrganization = "\(mcrpapiBaseURL)/system-organizations"
    static let organization = "\(mcrpapiBaseURL)/organizations"
    static let organizationMember = "\(mcrpapiBaseURL)/organization-members"
    static let accountComponent = "\(mcrpapiBaseURL)/accounts-components"
    static let accountSemiComponent = "\(mcrpapiBaseURL)/accounts-semi-components"
    static let singleChurch = "\(churches)/church"
    static var event: String { return "\(authpoint)/events\(populateAll)" }
    static let society = "\(mcrpapiBaseURL)/societies"
    static let societyEvent = "\(mcrpapiBaseURL)/society-events/by-society"
    static let register = "\(mcrpapiBaseAuth)/register-guest"
    static let registerMember = "\(mcrpapiBaseAuth)/register-member"
    static let login = "\(mcrpapiBaseAuth)/login"
    static let requestOTP = "\(mcrpapiBaseAccount)/request-otp"
    static let verifyOTP = "\(mcrpapiBaseAccount)/verify-otp"
    static let passwordResetFresh = "\(mcrpapiBaseAccount)/password-reset-fresh"
    static let requestPasswordReset = "\(mcrpapiBaseAccount)/request-password-reset"
    static let passwordReset = "\(mcrpapiBaseAccount)/password-reset"
    static let changePassword = "\(mcrpapiBaseAccount)/change-password"
}
