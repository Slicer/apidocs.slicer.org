# Slicer API documentation

This project hosts the Slicer API documentation served from http://apidocs.slicer.org.


## Automatic generation

Documentation is automatically generated and pushed to the `gh-pages` branch configured as a [GitHub Pages](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/) source.

The [slicer-apidocs-builder](https://github.com/Slicer/slicer-apidocs-builder) tool is used within a CircleCI
build to checkout Slicer source code, build doxygen documentation and publish generated html pages.

Each time the `main` branch of https://github.com/Slicer/Slicer is updated or each time a new release tag
is pushed, the generated documentation is either added to the `main` folder or added to a new folder
named after the release tag. Then the updated content is pushed to the `gh-pages` branch.

The simple GitHub post-receive web hook handler triggering a CircleCI build is
[github-circleci-trigger](https://github.com/Slicer/github-circleci-trigger). It is implemented as
a Flask application hosted on a free heroku instance.

## Squash of `gh-pages` branch using a scheduled GitHub Actions worklfow

After some time, the amount of data published on the `gh-pages` exceeds GitHub [recommended size of 1GB][max_size].
To cleanup the repository, a [scheduled workflow][schedule] associated with this project
will be triggered weekly and will execute [gh-pages-squash.sh](./gh-pages-squash.sh) script.

The script simply do a soft reset, amend the first commit and force push the branch `gh-pages`.

[max_size]: https://help.github.com/articles/what-is-my-disk-quota/
[schedule]: https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule


## Programmatically request updates of `gh-pages` branch using GitHub API

### Prequisites

* Generate GitHub token - See [here](https://github.com/settings/tokens)

### Squash *gh-pages*

*This is useful to debug the workflow without having to wait.*

```
GITHUB_TOKEN=<YOUR_GITHUB_TOKEN> ./trigger-workflow-squash.sh
```

# license

It is covered by the Slicer License:

https://github.com/Slicer/apidocs.slicer.org/blob/main/License.txt


