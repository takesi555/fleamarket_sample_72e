server '13.113.127.100', user: 'ec2-user', roles: %w{app db web}
# 自動デプロイに際して必要な動作

set :rails_env, "production"
set :unicorn_rack_env, "production"

# role-based syntax
# ==================