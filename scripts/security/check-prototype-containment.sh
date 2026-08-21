#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
compose_file="$repo_root/deployments/docker-compose.yml"
config_file="$repo_root/configs/config.yaml"
env_example_file="$repo_root/configs/.env.example"
migration_file="$repo_root/migrations/000027_remove_seeded_admin_users.up.sql"

if rg -n '^\s*- "(3306|6379|80|443):' "$compose_file"; then
  echo "prototype services must not bind public host ports" >&2
  exit 1
fi

rg -q '127\.0\.0\.1:3306:3306' "$compose_file"
rg -q '127\.0\.0\.1:6379:6379' "$compose_file"
rg -q '127\.0\.0\.1:8088:80' "$compose_file"
rg -q 'APP_ENV=local' "$compose_file"
rg -q 'TRON_ENABLED=false' "$compose_file"
rg -q 'DB_ROOT_PASSWORD:\?set DB_ROOT_PASSWORD' "$compose_file"
rg -q 'JWT_SECRET:\?set a random local JWT_SECRET' "$compose_file"

if rg -n 'root123456|change_me_in_production' "$compose_file"; then
  echo "prototype Compose contains a default credential" >&2
  exit 1
fi

rg -q '^  enabled: false$' "$config_file"
rg -q '^  secret: ""$' "$config_file"
rg -q '^JWT_SECRET=$' "$env_example_file"
rg -q '^BOT_TOKEN=$' "$env_example_file"
rg -q "DELETE FROM admin_users" "$migration_file"
rg -q "username = 'admin'" "$migration_file"
rg -q "role = 'super_admin'" "$migration_file"

echo "prototype containment checks passed"
