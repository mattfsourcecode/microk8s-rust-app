#!/usr/bin/env zsh

# Enable zsh-specific error handling
setopt ERR_EXIT
setopt PIPE_FAIL
setopt NO_UNSET

# Color definitions
typeset -A colors
colors=(
    [red]=$'\e[31m'
    [green]=$'\e[32m'
    [yellow]=$'\e[33m'
    [reset]=$'\e[0m'
)

# Function to print messages with color
print_message() {
    local color="${colors[$1]}"
    local message="$2"
    echo "${color}${message}${colors[reset]}"
}

# Function to check prerequisites
check_prerequisites() {
    local -a required_tools=(docker docker-compose curl)
    
    for tool in $required_tools; do
        if ! command -v $tool &> /dev/null; then
            print_message "red" "Error: $tool is not installed"
            return 1
        fi
    done
    
    print_message "green" "All prerequisites are satisfied"
}

# Function to create required directories
setup_directories() {
    local -a dirs=(models output .k8sgpt)
    
    for dir in $dirs; do
        if [[ ! -d $dir ]]; then
            mkdir -p $dir
            print_message "green" "Created directory: $dir"
        fi
    done
}

# Function to download model if not present
download_model() {
    local model_path="models/llama-3.2-1b-instruct-q4_k_m.gguf"
    local model_url="https://huggingface.co/hugging-quants/Llama-3.2-1B-Instruct-Q4_K_M-GGUF/resolve/main/llama-3.2-1b-instruct-q4_k_m.gguf"
    
    if [[ ! -f $model_path ]]; then
        print_message "yellow" "Downloading model..."
        curl -L $model_url -o $model_path
        if [[ $? -eq 0 ]]; then
            print_message "green" "Model downloaded successfully"
        else
            print_message "red" "Failed to download model"
            return 1
        fi
    else
        print_message "green" "Model already exists"
    fi
}

# Function to run in development mode
run_dev() {
    print_message "yellow" "Starting services in development mode..."
    docker-compose up -d
    print_message "green" "Services started successfully"
}

# Function to run in test mode
run_test() {
    print_message "yellow" "Starting services in test mode..."
    docker-compose -f docker-compose.yml -f docker-compose.test.yml up -d
    print_message "green" "Test environment started successfully"
}

# Main function
main() {
    local mode=${1:-dev}
    
    print_message "yellow" "Setting up environment..."
    
    # Check prerequisites
    check_prerequisites || return 1
    
    # Setup directories
    setup_directories || return 1
    
    # Download model if needed
    download_model || return 1
    
    # Run in specified mode
    case $mode in
        dev)
            run_dev
            ;;
        test)
            run_test
            ;;
        *)
            print_message "red" "Invalid mode. Use 'dev' or 'test'"
            return 1
            ;;
    esac
}

# Run main function with provided arguments
main "$@"

