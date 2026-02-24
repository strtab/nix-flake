#!/nix/store/5p86w1968gs5abgqkj9wv5gccxpy253c-bash-interactive-5.3p3/bin/bash
locked_state=$(busctl --user get-property org.freedesktop.secrets \
    /org/freedesktop/secrets/collection/login \
    org.freedesktop.Secret.Collection Locked)
if [[ "${locked_state}" == "b false" ]]; then
    echo 'Keyring is unlocked' >&2
    exit 0
else
    echo 'Keyring is locked' >&2
    exit 1
fi
