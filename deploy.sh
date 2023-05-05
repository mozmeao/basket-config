#!/bin/bash -ex

for DEPLOY in $1/*-deploy.yaml; do
    kubectl apply -f ${DEPLOY}
done
