# Slicer API documentation

This project hosts the Slicer API documentation served from http://apidocs.slicer.org.

## Automatic Generation and Publishing

The Slicer API documentation is automatically generated and published using a GitHub workflow. The
generated files are pushed to the `gh-pages` branch, which is configured as the source for
[GitHub Pages](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/).

### Workflow Triggers

The [trigger-doxygen-build-and-publish.yml](https://github.com/Slicer/Slicer/blob/main/.github/workflows/trigger-doxygen-build-and-publish.yml) workflow in the `Slicer/Slicer` repository initiates the process whenever:
- The `main` branch is updated.
- A new release tag is pushed.

### Documentation Generation

The [slicer-apidocs-builder](https://github.com/Slicer/slicer-apidocs-builder) tool handles the
generation and publication of documentation. It is invoked within the [doxygen-build-and-publish.yml](.github/workflows/doxygen-build-and-publish.yml) workflow maintained in this repository to:

1. Check out the Slicer source code.
2. Build the Doxygen documentation.
3. Publish the generated HTML files.

### Documentation Updates

- **Main Branch Updates**: Documentation for the `main` branch is added to the `main` folder.
- **Release Tags**: Documentation for new release tags is added to a folder named after the tag.

The updated content is pushed to the `gh-pages` branch, ensuring the documentation remains current and accessible.

## Managing the `gh-pages` Branch Size

Over time, the size of the `gh-pages` branch may exceed GitHub's [recommended limit of 1GB][max_size].
To manage this, a [scheduled workflow][schedule] is configured to run weekly. This workflow executes
the [gh-pages-squash.sh](./gh-pages-squash.sh) script, which performs the following actions:
1. Executes a soft reset.
2. Amends the first commit.
3. Force-pushes the `gh-pages` branch.

This ensures that the repository size remains within the recommended limits.

[max_size]: https://help.github.com/articles/what-is-my-disk-quota/
[schedule]: https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule

## Programmatic Updates of the `gh-pages` Branch

You can manually trigger updates to the `gh-pages` branch using the GitHub API. This is
useful for debugging or forcing a squash without waiting for the scheduled workflow.

### Prequisites

* Generate GitHub token - See [here](https://github.com/settings/tokens)

### Squash *gh-pages*

To trigger the squash workflow programmatically, run the following command:

```
GITHUB_TOKEN=<YOUR_GITHUB_TOKEN> ./trigger-workflow-squash.sh
```

# license

It is covered by the Slicer License:

https://github.com/Slicer/apidocs.slicer.org/blob/main/License.txt


