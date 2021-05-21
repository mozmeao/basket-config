#!/bin/bash -ex

JOB_FILE="${1}/pre-deploy-job.yaml"
# skip if no file
test -f "${JOB_FILE}" || exit 0

kubectl apply -f "${JOB_FILE}"

# see https://stackoverflow.com/a/60286538
# wait for the job to succeed or fail
kubectl wait --for=condition=complete -f "${JOB_FILE}" --timeout=20s &
completion_pid=$!
kubectl wait --for=condition=failed -f "${JOB_FILE}" --timeout=20s && exit 1 &
failure_pid=$!
# if the fail condition wins this will exit 1 and the job will not be deleted
wait -n $completion_pid $failure_pid

kubectl delete -f "${JOB_FILE}"
