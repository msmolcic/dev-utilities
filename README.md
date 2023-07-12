# Dev Utilities

Set of utility functions to make dev life easier.

## Shell functions

Before you start, make sure that you have latest version of [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed on your machine.

##### Windows users

You'll also need to make sure that you have [GitBash](https://gitforwindows.org/) installed, and that [jq](https://stedolan.github.io/jq/) is accessible at your environment path and is a known command in your system.

## Getting started

CLI access is best managed by adding the following to the user’s `~/.bashrc` or `~/.zshrc` (or whatever you use):

```
# Set as appropriate for your environment
export DEV_UTIL_GIT_ROOT="$HOME/git"

if ! [ -d "$DEV_UTIL_GIT_ROOT/dev-utilities" ]; then
  # GitHub access should already be configured.
  git clone git@github.com:msmolcic/dev-utilities.git "$DEV_UTIL_GIT_ROOT"/dev-utilities
fi

PATH="$DEV_UTIL_GIT_ROOT/dev-utilities/bin:$PATH"

for f in "$DEV_UTIL_GIT_ROOT"/dev-utilities/shell-functions/*.sh; do
  source "$f"
done
```

When a new tab is started, it will have access to custom shell functions that allow the user to do various things much faster using the set of custom commands.

## AWS Credentials Functions

### `aws-mfa`

To make this function work, make sure you have the following profile definition in your `~/.aws/credentials` file with actual values instead of the placeholders:

```
[main]
aws_access_key_id=${USER_AWS_ACCESS_KEY_ID}
aws_secret_access_key=${USER_AWS_SECRET_ACCESS_KEY}
mfa_serial=${USER_MFA_SERIAL}
region=us-west-2
```

Profile name `[main]` is really important factor, because some of the main logic revolves around that name (no pun intended).

`mfa_serial` is the ARN value of your MFA, e.g. `arn:aws:iam::123456789:mfa/mobile`.

This function is implemented on and mostly hide underlying aws session token functionality. When invoked you'll be asked to enter your MFA code. Upon successful login, temporary access token data is stored under the default profile in your `~/.aws/credentials` file and should allow you to execute follow up commands against AWS environments. These credentials are temporary and last for 24 hours.