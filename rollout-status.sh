#!/bin/bash

for DEPLOY in $1/*-deploy.yaml; do
    kubectl_1.11 rollout status -f ${DEPLOY}
done
