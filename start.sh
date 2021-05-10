#!/bin/sh
set -e

timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

INPUT_AUTHOR_EMAIL=${INPUT_AUTHOR_EMAIL:-'github-actions[bot]@users.noreply.github.com'}
INPUT_AUTHOR_NAME=${INPUT_AUTHOR_NAME:-'github-actions[bot]'}
INPUT_COAUTHOR_EMAIL=${INPUT_COAUTHOR_EMAIL:-''}
INPUT_COAUTHOR_NAME=${INPUT_COAUTHOR_NAME:-''}
INPUT_MESSAGE=${INPUT_MESSAGE:-"Commit from GitHub Actions"}
INPUT_BRANCH=${INPUT_BRANCH:-master}
INPUT_FORCE=${INPUT_FORCE:-false}
INPUT_REBASE=${INPUT_REBASE:-true}
INPUT_TAGS=${INPUT_TAGS:-false}
INPUT_EMPTY=${INPUT_EMPTY:-false}
INPUT_DIRECTORY=${INPUT_DIRECTORY:-'.'}

echo "Push to branch $INPUT_BRANCH";
[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

if ${INPUT_EMPTY}; then
    _EMPTY='--allow-empty'
fi

if ${INPUT_FORCE}; then
    _FORCE_OPTION='--force'
fi

if ${INPUT_TAGS}; then
    _TAGS='--tags'
fi

cd "${INPUT_DIRECTORY}"


git config http.sslVerify false
git config --local user.email "${INPUT_AUTHOR_EMAIL}"
git config --local user.name "${INPUT_AUTHOR_NAME}"

echo 'Staging files'
git add -A

echo 'Committing'
if [ -n "${INPUT_COAUTHOR_EMAIL}" ] && [ -n "${INPUT_COAUTHOR_NAME}" ]; then
    git commit -m "${INPUT_MESSAGE}


Co-authored-by: ${INPUT_COAUTHOR_NAME} <${INPUT_COAUTHOR_EMAIL}>" $_EMPTY || true
else
    git commit -m "{$INPUT_MESSAGE}" $_EMPTY || true
fi
echo 'Comitted'

if ${INPUT_REBASE}; then
    echo 'Rebasing'
    git fetch origin "${INPUT_BRANCH}" && git rebase origin/"${INPUT_BRANCH}";
    echo 'Rebased'
fi

git push origin HEAD:"${INPUT_BRANCH}" --follow-tags $_FORCE_OPTION $_TAGS;
echo 'Pushed'