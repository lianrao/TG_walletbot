# TG_walletbot Prototype Containment

## Status

This repository is a historical, no-value prototype with confirmed Critical
and High-impact funds defects. It is not an approved fallback for the new Wallet
Platform and cannot be promoted to Production by patching individual findings.

## Enforced local boundary

- Docker Compose publishes MySQL, Redis, and Nginx only on `127.0.0.1`.
- Compose uses `APP_ENV=local` and requires explicit random local database and
  JWT secrets; no default password is accepted.
- The Bot service is in the optional `bot` Profile and forces
  `TRON_ENABLED=false`.
- The checked-in YAML config has no JWT Secret or Bot Token and keeps TRON
  disabled.
- Migration `000027` removes only the exact fixed-hash `admin/super_admin`
  account created by `000022`; rollback never recreates it.

## Required credential response

Before any further shared demonstration, inventory and rotate or revoke:

1. administrator passwords, JWT secrets, and active administrator sessions;
2. Telegram Bot Tokens and Webhook Secrets;
3. Merchant API/Webhook Secrets;
4. database and Redis credentials;
5. TronGrid/API credentials and any encryption material;
6. hot-wallet keys, addresses, custody references, and provider credentials.

Do not record credential values in this document, an issue, a commit, or a
normal log. If any real key was ever present, rotation means moving all real
funds under an independently reviewed custody process, not merely changing the
database encryption key.

## Residual risk

The containment changes do not fix the ledger, withdrawal, deposit, replay,
red-packet, authorization, custody, dependency, or runtime findings. The prior
security coverage was partial. Keep Mainnet, public ingress, real credentials,
and real value disabled permanently.
