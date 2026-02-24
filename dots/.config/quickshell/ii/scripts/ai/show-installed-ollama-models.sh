#!/nix/store/5p86w1968gs5abgqkj9wv5gccxpy253c-bash-interactive-5.3p3/bin/bash

# Get the list, skip the header, and extract the first column (model names)
model_names=$(ollama list | tail -n +2 | awk '{print $1}')

# Build a JSON array
json_array="["
for name in $model_names; do
    json_array+="\"$name\","
done

# Remove trailing comma and close the array
json_array="${json_array%,}]"

# Output the JSON array
echo "$json_array"
