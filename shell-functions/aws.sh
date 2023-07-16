###
# User functions
###

# aws-mfa (<profile_name>)
#
# Invoking this adds temporary credentials in the ~/.aws/credentials file for the provided profile.
# Profile is optional and defaults to 'main'.
aws-mfa() {

  local profile_name=${1:-"main"}
  
  while true; do
    read -p "Enter MFA code: " mfa_code
    if [ -z "$mfa_code" ]; then
        echo "MFA code cannot be empty. Please try again."
    else
        break
    fi
  done

  aws-session-token "$mfa_code" "$profile_name"
}