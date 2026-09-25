#!/usr/bin/env bash
# Org and branch hygiene for manali-co. Run as the org owner (needs the
# admin:org scope for the org-level calls: gh auth refresh -h github.com -s admin:org):
#   ./scripts/protect-branches.sh
#
# Org:  base permission for members = read, members can't create repos, fork-PR
#       workflows only wait for approval from accounts brand-new to GitHub (so
#       your identity, your agents and established bots never queue).
# main: pull request required (0 approvals, threads resolved), linear history, no
#       force-push, no deletion, and only ADMIN_USER may push or merge. Admins are not
#       bound by the rules, so the owner can "bypass and merge" when needed (audited).
#       A requested change is still addressed through the PR, not dismissed.
#       On yapp the "ci" check must pass first.
# dev:  fair game. Pull request required, nothing else. Skipped on repos that
#       have no dev branch.
set -euo pipefail
ORG="manali-co"
ADMIN_USER="${ADMIN_USER:-ayushm-agrawal}"
REPOS=(yapp what-should-we-watch .github)

echo "== org"
gh api -X PATCH "orgs/$ORG" \
  -f default_repository_permission=read \
  -F members_can_create_repositories=false \
  -F members_can_create_public_repositories=false \
  -F members_can_create_private_repositories=false \
  -F members_can_fork_private_repositories=false \
  -F web_commit_signoff_required=false >/dev/null && echo "org: members read-only, no repo creation"
gh api -X PUT "orgs/$ORG/actions/permissions/fork-pr-contributor-approval" \
  -f approval_policy=first_time_contributors_new_to_github >/dev/null \
  && echo "org: workflow approval only for accounts new to GitHub"

protect_main() {
  local repo="$1" checks="$2"
  gh api -X PUT "repos/$ORG/$repo/branches/main/protection" --input - <<JSON >/dev/null
{"required_status_checks": $checks,
 "enforce_admins": false,
 "required_pull_request_reviews": {"required_approving_review_count": 0, "dismiss_stale_reviews": true},
 "restrictions": {"users": ["$ADMIN_USER"], "teams": [], "apps": []},
 "required_linear_history": true, "allow_force_pushes": false, "allow_deletions": false,
 "required_conversation_resolution": true}
JSON
  echo "$repo main: protected, pushes and merges restricted to $ADMIN_USER"
}

protect_dev() {
  local repo="$1"
  gh api "repos/$ORG/$repo/branches/dev" >/dev/null 2>&1 || { echo "$repo: no dev branch"; return; }
  gh api -X PUT "repos/$ORG/$repo/branches/dev/protection" --input - <<'JSON' >/dev/null
{"required_status_checks": null, "enforce_admins": false,
 "required_pull_request_reviews": {"required_approving_review_count": 0},
 "restrictions": null, "allow_force_pushes": false, "allow_deletions": false}
JSON
  echo "$repo dev: pull request required, otherwise open"
}

echo "== repos"
for repo in "${REPOS[@]}"; do
  gh api -X PUT "repos/$ORG/$repo/actions/permissions/fork-pr-contributor-approval" \
    -f approval_policy=first_time_contributors_new_to_github >/dev/null
done
protect_main yapp '{"strict": true, "contexts": ["ci"]}'
protect_dev  yapp
protect_main what-should-we-watch 'null'
protect_dev  what-should-we-watch
protect_main .github 'null'

echo
echo "Org owners (should be just you):"
gh api "orgs/$ORG/members?role=admin" --jq '.[].login'
