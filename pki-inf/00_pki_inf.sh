#!/usr/bin/env bash
# Execute all PKI setup scripts
./01_cert_auth.sh
./02_client_svr_certs.sh
./03_ctrlr_mgr_client_cert.sh
./04_kube_proxy_cert.sh
./05_scheduler_client_cert.sh
./06_k8s_api_srv_certs.sh
./07_sa_key_pair.sh
./08_distribute_certs.sh