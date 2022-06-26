#!/bin/bash

#================#
# ALB Controller #
#================#


echo "Adding required helm packages ...."
helm repo add eks https://aws.github.io/eks-charts

echo "Install the TargetGroupBinding CRDs if upgrading the chart via helm upgrade."
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

echo "Install the helm chart if using IAM roles for service accounts. "
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
 -n kube-system \
 --set clusterName=prd-eks-useast1-backend \
 --set serviceAccount.create=false \
 --set serviceAccount.name=aws-load-balancer-controller \
 --set vpcId=vpc-0f4a35f3131c1aa49 \
 --set replicaCount=1