#!/bin/bash

PS4='[Container] $(date "+%Y/%m/%d %H:%M:%S") '

echo "Checking branch naming convention..."
echo "account id: ${CODEBUILD_WEBHOOK_ACTOR_ACCOUNT_ID}"
echo "source repo: ${CODEBUILD_SOURCE_REPO_URL}"
echo "source version: ${CODEBUILD_SOURCE_VERSION}"
echo "source directory: ${CODEBUILD_SRC_DIR}"
echo "base ref: ${CODEBUILD_WEBHOOK_BASE_REF}"
echo "head ref: ${CODEBUILD_WEBHOOK_HEAD_REF}"

BRANCH_NAME="${CODEBUILD_WEBHOOK_HEAD_REF#refs/heads/}"
echo "BRANCH NAME: ${BRANCH_NAME}"

if echo "$BRANCH_NAME" | grep -Eq ".*(AQ|PROF|AQIN|INT|AOC|CX)[-_]{1}[0-9]{1,}.*"; then
      echo "Success: The base branch of the PR contains a valid ticket reference."
  else
    echo "Error: Please include a valid ticket reference in the branch name. eg:AQ-2345_bug_fix"
    exit 1
fi
