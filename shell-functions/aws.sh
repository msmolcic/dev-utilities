###
# User functions
###

aws-mfa() {
  read -p "Enter MFA code: " mfaCode
  aws-session-token "$mfaCode"
}