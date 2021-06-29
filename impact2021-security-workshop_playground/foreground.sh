#!/bin/bash

retry() {
    local -r -i max_attempts="$1"; shift
    local -i attempt_num=1
    until "$@"
    do
        if ((attempt_num==max_attempts))
        then
            echo "Attempt $attempt_num failed and there are no more attempts left!"
            return 1
        else
            printf "."
            sleep $((attempt_num++))
        fi
    done
}

echo "Waiting for Conjur to be ready"
retry 90 docker exec root_client_1 conjur list 2>/dev/null
echo "Above are the resources preloaded to Conjur.   Environmnet is now ready"
