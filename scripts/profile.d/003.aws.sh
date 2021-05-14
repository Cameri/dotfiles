export AWS_HOME="$HOME/.aws"
[ -f $AWS_HOME/.env ] && source $AWS_HOME/.env
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

export AWS_XRAY_CONTEXT_MISSING=LOG_ERROR
