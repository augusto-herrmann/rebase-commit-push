# GitHub Action for GitHub Commit & Push (with Rebase!)

This fork differs by adding support for the `rebase` flag.

The GitHub Actions for commiting & pushing to GitHub repository local changes authorizing using GitHub token.

With ease:
- update new code placed in the repository, e.g. by running a linter on it,
- track changes in script results using Git as archive,
- publish page using GitHub-Pages,
- mirror changes to a separate repository.

## Usage

### Example Workflow file

An example workflow to authenticate with GitHub Platform:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Create local changes
      run: |
        ...
    - name: Commit & Push changes
      uses: actions-js/push@master
      with:
        rebase: true
```

### Inputs

| name           | value   | default                     | description |
| -------------- | ------  | --------------------------- | ----------- |
| author_email   | string  | 'github-actions[bot]@users.noreply.github.com' | Email used to configure user.email in `git config`. |
| author_name    | string  | 'github-actions[bot]'       | Name used to configure user.name in `git config`. |
| coauthor_email | string  |                             | Email used to make a co-authored commit. |
| coauthor_name  | string  |                             | Name used to make a co-authored commit. |
| message        | string  | 'chore: autopublish ${date}' | Commit message. |
| branch         | string  | 'master'                    | Destination branch to push changes. |
| empty          | boolean | false                       | Allow empty commit. |
| force          | boolean | false                       | Determines if force push is used. |
| rebase         | boolean | true                        | Determines if a rebase should be performed before pushing. |
| tags           | boolean | false                       | Determines if `--tags` is used. |
| directory      | string  | '.'                         | Directory to change to before pushing. |
| repository     | string  | ''                          | Repository name. Default or empty repository name represents current github repository. If you want to push to other repository, you should make a [personal access token](https://github.com/settings/tokens) and use it as the `github_token` input.  |

## License

[MIT License](LICENSE).

## Credits

This is a slight modification [actions-js/push](https://github.com/actions-js/push) which is a slight modification of [ad-m/github-push-action](https://github.com/ad-m/github-push-action).

## No affiliation with GitHub Inc.

GitHub are registered trademarks of GitHub, Inc. GitHub name used in this project are for identification purposes only. The project is not associated in any way with GitHub Inc. and is not an official solution of GitHub Inc. It was made available in order to facilitate the use of the site GitHub.