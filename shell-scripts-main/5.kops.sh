export KOPS_STATE_STORE="s3://k8sbucket777"
export CONTROL_PLANE_SIZE="t3.medium"
export NODE_SIZE="t3.small"
export ZONES="us-east-2a,us-east-2b"

kops create cluster --name=devopsprojects.store \
    --node-count 2 \
    --zones $ZONES \
    --node-size $NODE_SIZE \
    --control-plane-size $CONTROL_PLANE_SIZE \
    --control-plane-zones us-east-2a \
    --dns-zone Z014790038ULCSA62ANIV \
    --yes
