#!/bin/bash -e

# Register new task definition for the current SHA1

environment="$1"
service_name="$2"
sha1="$3"

# Fetch the latest task definition from ECS
TASK_DEFINITION_JSON=$(aws ecs describe-task-definition --task-definition "${service_name}-${environment}" \
  | jq .taskDefinition \
  | jq 'del(.requiresAttributes, .revision, .status, .taskDefinitionArn)')

# Replace the image tag with the current SHA1
NEW_TASK_DEFINITION_JSON=$(echo ${TASK_DEFINITION_JSON} \
  | jq ".containerDefinitions[].image |= if contains(\"${service_name}:\") then sub(\"${service_name}:.*\";\"${service_name}:${sha1}\") else . end")

# Register a new task definition
aws ecs register-task-definition --cli-input-json "${NEW_TASK_DEFINITION_JSON}"
