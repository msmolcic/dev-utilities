[![License](https://img.shields.io/badge/license-MIT-green)](https://github.com/YourGithubUsername/YourRepositoryName/blob/main/LICENSE)
[![Email](https://img.shields.io/badge/Email-gray?logo=gmail&style=flat-square)](mailto:mario.smolcic@rokolabs.com)
[![Stack Overflow](https://img.shields.io/badge/Stackoverflow-gray?logo=stackoverflow&style=flat-square)](https://stackoverflow.com/users/3284114/msmolcic)
[![Linkedin](https://img.shields.io/badge/-LinkedIn-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/yourusername)](https://www.linkedin.com/in/msmolcic/)
[![Twitter Follow](https://img.shields.io/twitter/follow/MarioSmolcic?style=social)](https://twitter.com/MarioSmolcic)

# Dev Utilities

This repository is a collection of utility functions designed to streamline development workflows. The shell functions are particularly useful for developers using AWS services, as they facilitate operations such as AWS Multi-Factor Authentication (MFA).

## Prerequisites

- Make sure that you have the latest version of the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed on your machine.
- [jq](https://stedolan.github.io/jq/) should also be installed and accessible in your environment path.
- For Windows users, [GitBash](https://gitforwindows.org/) needs to be installed.
- A valid AWS MFA setup for your account is necessary for some functions.

## Getting Started

To integrate these utilities into your workflow, add the following to your shell's startup file, which could be `~/.bashrc`, `~/.zshrc`, or equivalent depending on your environment:

```bash
# Set as appropriate for your environment
export DEV_UTIL_GIT_ROOT="$HOME/git"

if ! [ -d "$DEV_UTIL_GIT_ROOT/dev-utilities" ]; then
  # Ensure your GitHub access is configured.
  git clone git@github.com:msmolcic/dev-utilities.git "$DEV_UTIL_GIT_ROOT"/dev-utilities
fi

PATH="$DEV_UTIL_GIT_ROOT/dev-utilities/bin:$PATH"

for f in "$DEV_UTIL_GIT_ROOT"/dev-utilities/shell-functions/*.sh; do
  source "$f"
done
```

This setup provides access to custom shell functions that significantly speed up common tasks.

## AWS Credentials Functions

### `aws-mfa <profile_name>`
This function handles MFA for your AWS profiles. The `<profile_name>` parameter is optional and defaults to "main" if not provided.

For this function to work correctly, make sure you have a profile defined in your `~/.aws/credentials` file and the corresponding configuration in your `~/.aws/config` file:

`~/.aws/credentials`

```bash
[profile_name]
aws_access_key_id=${USER_AWS_ACCESS_KEY_ID}
aws_secret_access_key=${USER_AWS_SECRET_ACCESS_KEY}
```

`~/.aws/config`

```bash
[profile profile_name]
region=us-west-2
mfa_serial=${USER_MFA_SERIAL}
```

Replace `profile_name` with the name of your profile. If you use "main" as the profile name, that will be the default profile used by `aws-mfa` when no profile is specified.

The `mfa_serial` value is the ARN of your MFA, e.g. `arn:aws:iam::123456789:mfa/mobile`.

When invoked, `aws-mfa` prompts you to enter your MFA code. Upon successful login, temporary access token data is stored under the 'default' profile in your `~/.aws/credentials` file, enabling you to execute follow-up commands against AWS environments. Note that these credentials are temporary and last for 24 hours.

## Warning
These scripts directly modify the `~/.aws/credentials` file. Ensure to keep a backup of your AWS credentials before using these scripts.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.