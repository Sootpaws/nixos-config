# Extract and export Home Manager environment variables

# Extract the variables from the Home Manager environment script
let vars = (open ~/.nix-profile/etc/profile.d/hm-session-vars.sh |
    split row "\n" |
    where { |it| str starts-with "export " } |
    parse "export {name}={value}")

# Generate an equivalent Nu script
let script = ($vars | each { |it|
    $"$env.($it.name) = ($it.value)"
})

# Write it to a temporary file
$script | save --force "/tmp/nu_env_setup.nu"

# This will later be sourced and removed by config.nu
