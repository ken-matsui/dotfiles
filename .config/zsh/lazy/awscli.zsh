if [[ -d ~/.aws ]]; then
  export AWS_DEFAULT_REGION=$(cat ~/.aws/config | grep 'region' | awk '{printf $3}')
  export AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials | grep 'aws_access_key_id' | awk '{printf $3}')
  export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials | grep 'aws_secret_access_key' | awk '{printf $3}')
fi
