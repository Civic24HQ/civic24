///  Use snake_case for key names.
///  Prefix keys with a category or context for better organization
/// (e.g., kAnalyticButton, kAnalyticEvent, kAnalyticScreen).
///  Keep names descriptive and concise to indicate their purpose.
library;

// General Names
const kAnalyticViewClass = 'FlutterViewController'; // This is the default screen class for Flutter.
const kAnalyticOverlayClass = 'FlutterOverlayView'; // Overlay screen class e.g., dialogs, bottom sheets.

// Button Clicks
const kAnalyticButtonAuthLogout = 'auth_logout';
const kAnalyticButtonAuthLogin = 'auth_login';
const kAnalyticButtonAuthSignUp = 'auth_sign_up';
const kAnalyticButtonResetPassword = 'reset_password';
const kAnalyticButtonAuthGoogle = 'auth_continue_with_google';
const kAnalyticButtonAuthApple = 'auth_continue_with_apple';
const kAnalyticsButtonAddReport = 'add_report';

// Events
const kAnalyticEventBecomeOnboardingCompleted = 'onboarding_completed';

// Parameters

// Bottom Sheets Name

// Dialogs Name
const kAnalyticDialogLogoutConfirmation = 'LogoutConfirmationDialog';
