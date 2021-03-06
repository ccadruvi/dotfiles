alias k="kubectl"
alias kg="kubectl get"

pl() {
    if [ -z "$1" ] ; then
        kubectl get pods --all-namespaces
    else
        kubectl get pods --all-namespaces | grep -i "$1"
    fi
}

pd() {
    if [ -z "$1" ] ; then
        echo "pattern missing" >&2
        return 1
    fi
    pod_line="$(kubectl get pods --all-namespaces | grep -i "$1" -m 1)"
    pod_id="$(echo "$pod_line" | awk '{print $2}')"
    pod_ns="$(echo "$pod_line" | awk '{print $1}')"
    if [ -n "$(which jq)" ] ; then
        kubectl get pod "$pod_id" --namespace "$pod_ns" -o json | jq .
    else
        kubectl describe pod "$pod_id" --namespace "$pod_ns"
    fi
}

px() {
    if [ -z "$1" ] ; then
        echo "pattern missing" >&2
        return 1
    fi
    pod_line="$(kubectl get pods --all-namespaces | grep -i "$1" -m 1)"
    pod_id="$(echo "$pod_line" | awk '{print $2}')"
    pod_ns="$(echo "$pod_line" | awk '{print $1}')"
    kubectl exec -it "$pod_id" --namespace "$pod_ns" -- /bin/sh
}

