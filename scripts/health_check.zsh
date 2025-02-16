#!/usr/bin/env zsh

# Enable error handling
setopt ERR_EXIT PIPE_FAIL NO_UNSET WARN_CREATE_GLOBAL

# Define colors for output
typeset -A colors
colors=(
'reset' $'\033[0m'
'red' $'\033[31m'
'green' $'\033[32m'
'yellow' $'\033[33m'
'blue' $'\033[34m'
)

# Constants
typeset -r MAX_RETRIES=3
typeset -r TIMEOUT=10
typeset -r RETRY_DELAY=5

# Helper functions
function print_status() {
local message=$1
local status=$2
if [[ $status -eq 0 ]]; then
    print "${colors[green]}✓ ${message}${colors[reset]}"
else
    print "${colors[red]}✗ ${message}${colors[reset]}"
    return 1
fi
}

function check_command() {
local cmd=$1
which $cmd &>/dev/null || {
    print "${colors[red]}Error: $cmd not found${colors[reset]}"
    return 1
}
}

function check_localai() {
local retries=0
while (( retries < MAX_RETRIES )); do
    if curl -s --max-time $TIMEOUT "http://localhost:8080/health" | grep -q "ok"; then
    print_status "LocalAI service is healthy" 0
    return 0
    fi
    ((retries++))
    print "${colors[yellow]}Retrying LocalAI health check ($retries/$MAX_RETRIES)${colors[reset]}"
    sleep $RETRY_DELAY
done
print_status "LocalAI service is not responding" 1
return 1
}

function check_k8sgpt() {
local retries=0
while (( retries < MAX_RETRIES )); do
    if k8sgpt version &>/dev/null; then
    print_status "K8sGPT service is healthy" 0
    return 0
    fi
    ((retries++))
    print "${colors[yellow]}Retrying K8sGPT health check ($retries/$MAX_RETRIES)${colors[reset]}"
    sleep $RETRY_DELAY
done
print_status "K8sGPT service is not responding" 1
return 1
}

function check_kube_app() {
local retries=0
while (( retries < MAX_RETRIES )); do
    if curl -s --max-time $TIMEOUT "http://localhost:3000/health" | grep -q "ok"; then
    print_status "Kube application is healthy" 0
    return 0
    fi
    ((retries++))
    print "${colors[yellow]}Retrying Kube application health check ($retries/$MAX_RETRIES)${colors[reset]}"
    sleep $RETRY_DELAY
done
print_status "Kube application is not responding" 1
return 1
}

# Main
function main() {
print "${colors[blue]}Starting health checks...${colors[reset]}"

# Check required commands
check_command "curl" || return 1
check_command "k8sgpt" || return 1

# Initialize status
local -i status=0

# Run health checks
check_localai || status=1
check_k8sgpt || status=1
check_kube_app || status=1

if [[ $status -eq 0 ]]; then
    print "\n${colors[green]}All services are healthy!${colors[reset]}"
    return 0
else
    print "\n${colors[red]}One or more services are unhealthy${colors[reset]}"
    return 1
fi
}

main "$@"

