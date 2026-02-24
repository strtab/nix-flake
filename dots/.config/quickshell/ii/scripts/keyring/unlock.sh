#!/nix/store/5p86w1968gs5abgqkj9wv5gccxpy253c-bash-interactive-5.3p3/bin/bash
# Based on https://unix.stackexchange.com/a/602935

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Skip if already unlocked
if "${SCRIPT_DIR}/is_unlocked.sh"; then
    exit 1
fi

# Prompt for password if not provided
if [[ -z "${UNLOCK_PASSWORD}" ]]; then
    echo -n 'Login password: ' >&2
    read -s UNLOCK_PASSWORD || return
fi

# Unlock
killall -q -u "$(whoami)" gnome-keyring-daemon
eval $(echo -n "${UNLOCK_PASSWORD}" \
           | gnome-keyring-daemon --daemonize --login \
           | sed -e 's/^/export /')
unset UNLOCK_PASSWORD
echo '' >&2
