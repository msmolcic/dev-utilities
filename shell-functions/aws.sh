###
# User functions
###

# aws-mfa (<profileName>)
#
# Invoking this adds temporary credentials in the ~/.aws/credentials file for the provided profile.
# Profile is optional and defaults to 'main'.
aws-mfa() {

  local profileName=${1:-"main"}
  
  while true; do
    read -p "Enter MFA code: " mfaCode
    if [ -z "$mfaCode" ]; then
        echo "MFA code cannot be empty. Please try again."
    else
        break
    fi
  done

  aws-session-token "$mfaCode" "$profileName"
}