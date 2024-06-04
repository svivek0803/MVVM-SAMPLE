//
//  Constants.swift
//  ExpatLand
//
//  Created by User on 01/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    
    
    
    struct FontName {
        static let regular = "NHaasGroteskTXPro-55Rg"
        static let bold = "NHaasGroteskTXPro-75Bd"
    }
    

    enum HttpRequestHeaderName: String {
        case authorization = "Authorization"
        case refreshToken = "refreshtoken"
        case expires = "Expires"
        case bearer = "Bearer"
    }
    
    
    
    static let requestJsonHeaders = ["Content-Type": "application/json","Accept": "application/json"]
    static let requestMultipartHeaders = ["Content-Type": "multipart/form-data; boundary=\(boundary)","Accept": "application/json"]
    static let boundary = "Boundary-\(UUID().uuidString)"
    static let userDefaults  = UserDefaults.standard
    
    
    enum APIEndpoint: String {
        
        case baseUrl = ""
        case signIn = "/api/sign-in"
        case signUp = "/api/sign-up"
        case defaultPassword = "/api/default-password"
        case countries = "/api/countries"
        case cities = "/api/cities"
        case expertise = "/api/expertise"
        case memberships = "/api/memberships"
        case contactUs = "/api/contact-us/send"
        case forgotPassword = "/api/forgot-password"
        case resetPassword = "/api/reset-password"
        case verifyEmail = "/api/verify-email"
        case signOut = "/api/sign-out"
        case account = "/api/account"
        case users = "/api/users"
        case deleteAccount = "/api/delete-account"
        case editAccount = "/api/account/edit"
        // filter
        case filtering = "/api/filtering?"
        case regions = "/api/filter/regions"
        case filterCountries = "/api/filter/countries"
        case filterCities = "/api/filter/cities"
        case filterMemberShips = "/api/filter/memberships"
        case filterExpertise = "/api/filter/expertise"
        //chat
        case createGroup = "/api/group/create"
        case getGroup = "/api/group/get"
        case getGroupConversation = "/api/group/conversation/get"
        case groupConversationSend = "/api/group/conversation/send"
        case seenMessages = "/api/group/seen"
        case notificationStatus = "/api/account/update-notification-status"
        case renameGroup = "/api/group/rename"
        
        // pusher
        case  broadCasting = "/broadcasting/auth"
        case  beamsAuthUrl = "/api/pusher/beams-auth" 
    }
    
    
    struct TextConstant{
        static let registration = "Registration"
        static let register = "Register"
        static let signIn = "Sign In"
        static let backToSignIn = "Back to Sign in"
        static let resetPassword = "Reset Password"
        static let password = "Password"
        static let resetPASSWORD = "RESET PASSWORD"
        static let requestResetLink = "Request reset link"
        static let forgotPassword = "FORGOT YOUR PASSWORD?"
        static let checkEmail = "CHECK YOUR EMAIL"
        static let email = "Email"
        static let name = "Name"
        static let firstName = "First Name"
        static let lastName = "Last Name"
        static let company = "Company"
        static let secondaryEmail = "Secondary Email"
        static let country = "Country"
        static let city = "City"
        static let region = "Region"
        static let expertise = "Area of Expertise"
        static let membership = "Membership"
        static let newPassword = "New Password"
        static let titlePlaceholder = "Title"
        static let phoneNumber = "Phone number"
        static let confirmPassword = "Confirm Password"
        static let repeatNewPassword = "Repeat New Password"
        static let newPasswordNote = "Please create a new password in order to login."
        static let resetPasswordNote = "To make sure your account is secure, you will be logged out from other devices once you set the new password."
        static let chooseImage = "Choose Image"
        static let title = "Title"
        static let chooseAttachmets = "Choose Attachments"
        static let camera = "Camera"
        static let document = "Documents"
        static let video = "Video"
        static let gallery = "Gallery"
        static let cancel = "Cancel"
    }
  
    
    enum LabelText: String {
        static func localizedString(_ item: LabelText) -> String {
            return NSLocalizedString(item.rawValue, comment: "")
        }
        
        case _for = "for"
        case okUpperCase = "Ok"
        case cancel = "Cancel"
        case goToSettings = "Go To Settings"
        case numpadAplyText = "Done"
        
    }
    
    enum ColorName: String {
        
        // Base Colors
        case appBaseWhite = "appBaseWhite"
        case appBaseGrey = "appBaseGrey"
        case appBaseBaltic = "appBaseBaltic"
        case appBaseWhiteSmoke = "appBaseWhiteSmoke"
        case appBaseSmoke = "appBaseSmoke"
        case appBaseCaper = "appBaseCaper"
        
        // Primary Colors
        case appPrimaryDeepAqua = "appPrimaryDeepAqua"
        case appPrimaryAquaSqueeze = "appPrimaryAquaSqueeze"
        case appPrimaryMacawBlueGreen = "appPrimaryMacawBlueGreen"
        case appPrimaryGradientStart = "appPrimaryGradientStart"
        case appPrimaryGradientEnd = "appPrimaryGradientEnd"
        
        // Secondary Colors
        case appSecondaryRed = "appSecondaryRed"
        case appSecondaryTopaz = "appSecondaryTopaz"
        
        // cell Backbround
        case appCellColor = "appCellColor"
        case appBottomShadowColor = "appBottomShadowColor"
        
        // state color
        case appPressedStateColor = "appPrimaryPressedStateColor"
        case appDisabledStateColor = "appPrimaryDisabledStateColor"
    }
    
    
    struct Color {
        static let appDefaultColor = UIColor(named : ColorName.appPrimaryDeepAqua.rawValue)!
        static let appDefaultErrorColor = UIColor(named : ColorName.appSecondaryRed.rawValue)!
        static let appBaseBalticColor = UIColor(named : ColorName.appBaseBaltic.rawValue)!
        static let appBaseWhiteColor = UIColor(named : ColorName.appBaseWhite.rawValue)!
        static let appBaseSmokeColor = UIColor(named : ColorName.appBaseSmoke.rawValue)!
        static let appBaseCaperColor = UIColor(named : ColorName.appBaseCaper.rawValue)!
        static let appBaseWhiteSmokeColor = UIColor(named : ColorName.appBaseWhiteSmoke.rawValue)!
        static let appCellBackgroundColor = UIColor(named : ColorName.appCellColor.rawValue)!
        static let appPressedStateColor = UIColor(named : ColorName.appPressedStateColor.rawValue)!
        static let appDisabledStateColor = UIColor(named : ColorName.appDisabledStateColor.rawValue)!
        static let appBottomShadowColor = UIColor(named : ColorName.appBottomShadowColor.rawValue)!
        static let appSecondaryTopazColor = UIColor(named : ColorName.appSecondaryTopaz.rawValue)!
        static let appBaseGreyColor = UIColor(named : ColorName.appBaseGrey.rawValue)!

    }
    
    enum NotificationTitle: String {
        static func localizedString(_ item: NotificationTitle) -> String {
            return NSLocalizedString(item.rawValue, comment: "")
        }
        
        case empty = "empty"
    }
    
    enum GifName: String {
        case loading = "Loading_Spinner"
        case splash = "Splash_logo_animation"
    }
    
    enum ViewController_Identifiers: String {
        case termsAndConditions = "TermsConditionsVC"
        case FAQ = "FaqVC"
        case contactUs = "ContactUsVC"
        
    }
    enum Storyboards: String {
        case onboarding = "OnBoarding"
        case dashboard = "Dashboard"
        case helpMenuScreens = "HelpMenuScreens"
    }
    
    
    static let animatingImageViewSize = CGSize(width: 96, height: 96)
    static let loadingViewGifAnimatingDuration: Double = 1.2
    
    enum AlertMessage: String {
        static func localizedString(_ item: AlertMessage) -> String {
            return NSLocalizedString(item.rawValue, comment: "")
        }
        
        case success = "Success!"
        case verificationLinkWasSent = "An account verification link has been sent to you. Please check your email."
        case notWhiteListed = "Thank you for applying to become an E-Team member. You're submission will be reviewed within 2 business days."
        case alreadyRegistered = "An account already exists with the entered secondary email address."
        case productNotAvailable = "Sorry! This product is currently not available."
        case purchaseSuccess = "Thank you! Your purchase was successful. A confirmation email has been sent to you."
        case productPurchasePointsLess = "Insufficient funds."
        case emailOrPasswordIncorrect = "The e-mail address or password you have entered is incorrect."
        case registerationPending = "Your registration application is currently being reviewed."
        case pleaseVerifyEmail = "Your email address has not been verified. Please check your email and follow the link to verify."
        case accountExistWithSuchEmail = "An account already exists with this email address."
        case accountNotFoundWithSuchEmail = "Sorry, we couldn’t find an account with that email."
        case resetPasswordLinkExpired = "Your password reset link has expired."
        case emailVerifyError = "Sorry! There was an issue with verifying your email. Please revisit the verification link again."
        case emailVerifySuccess = "Your account has been verified. You are now able to sign in."
        case notificationDisabling = "By turning off the notifications you will stop being notified when visiting zones. Press ‘Cancel’ to keep the notifications on. Press ‘Confirm’ to turn the notifications off."
        case resetPasswordSuccess = "Your password has been reset."
        case haveEarnedAllCoinsForThisMonth = "You have earned all available Coins for this month. Your Coin limit will be refreshed next month and you can start earning again."
        case haveEarnedCoinsForEvent = "You have already earned Coins for this event."
        case invalidEvent = "Invalid event or event no longer exist."
        case eventCheckInSuccess = "Coins have been added to your balance."
        case generalError = "Sorry, an unexpected error has occurred."
        case oneHourError = "You must stay inside the zone for at least 1 hour in order to be able to check in to the following events."
        case mustBeInsideZone = "You are not inside a zone. Please travel to one of the yellow zones marked on the map and then click the play button to start earning Coins."
        case constactUsSuccess = "Thank you. Your message has been received and will be responded to within 72 hours."
        case logoutFailureOffline = "Wait! If you log out while you have Coins stored from your offline visitations, you will lose your progress. Press 'Cancel' to stay logged in. Press 'Confirm' to log out."
        case logoutFailureBasePoint = "Wait! If you log out before one hour is up, you will not receive your Coints. Press ‘Cancel’ to stay logged in. Press ‘Confirm’ to log out."
        case sessionExpired = "Session Expired. Please log in again."
        case changeLocationPermission = "Set Allow Location Access to Always to allow ‘TripCoin’ to track your location."
        case locationAccess = "Location Access"
        case youHaveStopped = "You have stopped the timer. Any earned Coins have been added to your balance."
        case waitTrackStop = "Wait! If you stop the timer before one hour is up, you will not receive your Coins. Press ‘Cancel’ to resume the timer. Press ‘Confirm’ to stop the timer."
        case notificationOfflineError = "This operation cannot be performed while offline."
        case maxUserLimitReached = "You may only select 9 users to create a group chat with. Please unselect a user in order to select this user."
        case cameraAccessPermissionText =  "Camera access permission and external storage access permissions are required in order to take and upload photos. Please allow these permissions from the device settings"
        case photoLibraryPermissionText = "External storage access permission is required in order to upload files. Please allow this permission from the device settings."
        case permissionDenied = "Permission Denied"
        case AlreadyExist = "Already Exist"
        case maxFileSize = "The maximum file/image size is 16MB."
        case maxImageUpload = "You may only upload 3 images at a time."
        case fileValidationError = "The message must be a file of type: png, jpg, jpeg, csv, xlx, xls, pdf, mp4, mov, ogg, qt, mp3, zip, doc, pdf, docx."
       
    }
    
   
}

struct ErrorMessages{
    static let errorToHandleInSuccess = "Something is wrong while getting success"
    static let errorToHandleInFailure = "Something is wrong while getting failure"
    static let errorNothingToLog = "There is nothing to log on console"
    static let somethingWentWrong = "Something went wrong"
    static let unableToParseError = "Unable to parse error response"
    static let invalidUserId = "Unable to find userId"
    static let networkError = "Network not available"
    
}

struct Console{
    static func log(_ message: Any?){
        print(message ?? ErrorMessages.errorNothingToLog)
    }
}

struct Validation{
    static let errorEmptyTextFeild = "This field is required."
    static let errorEmailEmpty = "Please enter email address."
    static let errorPasswordEmpty = "Please enter password."
    static let errorEnterOTP = "Please fill otp."
    static let errorFirstNameEmpty = "Please enter first name."
    static let errorNameEmpty = "Please enter  name."
    static let errorLastNameEmpty = "Please enter last name."
    static let errorDOBEmpty = "Please enter date of birth."
    static let errorSelectDoctorEmpty = "Please select referral."
    static let errorDescriptionEmpty = "Please enter feedback."
    static let errorIntertNameAndUsername = "Please insert name and surname."
    static let errorSelectDate = "Please select date."
    static let errordesc = "Please enter place."
    static let errorSignature = "Please add your signature in signature field to proceed further."
    static let errorSelectFeedbackIcon = "Please select feedback icon."
    
    static let errorCreateUsername = "Please create username."
    static let errorConfirmUsername = "Please confirm username."
    static let errorUsernameNotMetched = "Username mismatched."
    static let errorEmailInvalid = "Invalid email address. Example: johndoe@domain.com"
    static let errorSelectIndustry = "Please select Industry."
    static let errorSelectLocation = "Please select location."
    static let errorUsername = "Please enter username."
    
    static let errorEnterOldPassword = "Please enter current password."
    static let errorEnterNewPassword = "Please enter new password."
    static let errorEnterConfirmPassword = "Please enter confirm password."
    static let errorEnterOldNewPasswordSame = "Current and new password can't same"
    static let errorEmptyCountry = "Please select country."
    static let errorEmptyCity = "Please select city."
    static let errorEmptyCountryCode = "Please enter country code."
    static let errorEmptyPhoneNumber = "Please enter phone number."
    static let errorInvalidPhoneNumber = "Please enter valid phone number."
    static let errorNotNumeric = "Please enter numbers."
    static let errorPhoneLength = "Phone Number should be between 8 to 15 digits."
    
    static let errorNameInvalid = "Please enter valid name"
    static let errorNameLength = "Name should be between 3 to 10 characters."
    static let errorPasswordInvalid = "Password must be at least 6 characters up to max 15."
    static let errorPasswordLength = "Password should be less than 15 characters."
    static let errorPasswordLengthInvalid = "Password must include a minimum of six (6) letters, numbers or symbols."
    static let errorConfirmPasswordLengthInvalid = "Password must contain characters between 6 to 10."
    static let errorPasswordMismatch = "Password fields do not match. Please try again."
    static let errorNointernet = "No Internet connection."
}

struct ServerKeys {
    static let firstName = "first_name"
    static let lastName = "last_name"
    static let email = "email"
    static let phoneNumber = "phone"
    static let data = "data"
    static let message = "message"
    static let token = "token"
    static let image = "image"
    static let pdf = "signature_doc"
    static let username = "username"
    static let password = "password"
    static let socialId = "social_id"
    static let requestType = "login_type"
    static let social = "social"
    static let userImage = "user_image"
    static let newPassword = "newPassword"
    static let emailVerify = "emailVerify"
    static let type = "type"
    static let page = "page"
    static let status = "status"
    static let notification = "notification"
    static let name = "name"
  

}

struct UserDefaultKeys{
    static let accessToken = "accessToken"
    static let tokenType = "tokenType"
    static let isLoggedIn = "isLoggedIn"
    static let userId = "userId"
    static let notificationToken = "notificationToken"
    static let notificationStatus = "notificationStatus"
}


struct CellIdentifier {
    static let collectionCellEventStories = "CollectionCellEventStories"
    static let tableCellEventStories = "TableCellEventStories"
    static let collectionCellMoreStories = "CollectionCellMoreStories"
    static let tableCellMoreStories = "TableCellMoreStories"
    static let filterHeaderView = "FilterHeaderView"
    static let homeNoDataTableViewCell = "HomeNoDataTableViewCell"
    static let homeUserTableViewCell = "HomeUserTableViewCell"
    static let messageCell = "MessageCell"
    static let imageTableCell = "WCImageTableCell"
    static let videoTableCell = "WCVideoTableCell"
    static let descriptionTableCell = "WCDescriptionTableCell"
    static let OSSingleLabelCell = "OSSingleLabelCell"
    static let groupUserCell = "GroupUserCell"
    
    // chat
    static let incomingTextMessageCellID = "incomingTextMessageCellID"
    static let incomingFileMessageCellID = "IncomingFileMessageCellID"
    static let typingIndicatorCellID = "typingIndicatorCellID"
    static let photoMessageCellID = "photoMessageCellID"
    static let outgoingTextMessageCellID = "outgoingTextMessageCellID"
    static let outgoingFileMessageCellID = "OutgoingFileMessageCellID"
    static let typingIndicatorDatabaseID = "typingIndicator"
    static let incomingPhotoMessageCellID = "incomingPhotoMessageCellID"
    static let informationMessageCellID = "informationMessageCellID"

    
}


struct ScreenSize {
  static let width = UIScreen.main.bounds.size.width
  static let height = UIScreen.main.bounds.size.height
  static let maxLength = max(ScreenSize.width, ScreenSize.height)
  static let minLength = min(ScreenSize.width, ScreenSize.height)
  static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
}

struct DeviceType {
  static let iPhone4orLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
  static let iPhone5orSE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0
  static let iPhone678 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667.0
  static let iPhone678p = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736.0
  static let iPhoneX = UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.maxLength == 812.0 || ScreenSize.maxLength == 896.0)
  
  static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1024.0
  static let IS_IPAD_PRO = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1366.0
}
