#!/bin/sh

if ! aws --version > /dev/null 2>&1; then
  echo install awscli: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
  exit 1
fi

target_profile=${1:-default}
role_arn=$(aws configure get "${target_profile}".role_arn)
role_session_name=$(aws configure get "${target_profile}".role_session_name)
if [ "${role_session_name}" = "" ]; then
  role_session_name=${target_profile}-session
fi
serial_number=$(aws configure get "${target_profile}".mfa_serial)

echo "Enter token for the MFA serial \"${serial_number}\": "
read -r mfa_code

AWS_STS_CREDENTIALS=$( \
  aws sts assume-role \
    --role-arn "${role_arn}" \
    --role-session-name "${role_session_name}" \
    --serial-number "${serial_number}" \
    --token-code "${mfa_code}" \
)

AWS_ACCESS_KEY_ID=$(echo "${AWS_STS_CREDENTIALS}" | jq -r '.Credentials.AccessKeyId')
export AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY=$(echo "${AWS_STS_CREDENTIALS}" | jq -r '.Credentials.SecretAccessKey')
export AWS_SECRET_ACCESS_KEY

AWS_SESSION_TOKEN=$(echo "${AWS_STS_CREDENTIALS}" | jq -r '.Credentials.SessionToken')
export AWS_SESSION_TOKEN
