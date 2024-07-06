# Bitbucket Pipelines Pipe: SBOM Generator

A lightweight Bitbucket Pipe which generates a Software Bill of Materials
utilitizing the popular [Syft](https://github.com/anchore/syft?tab=readme-ov-file)
CLI tool for a given project or container image.

The official copy this project is hosted on
[Bitbucket](https://bitbucket.org/ccideas1/syft-pipe/src/main/). In order to reach
a diverse audience a copy of the repo also exists in
[GitHub](https://github.com/ccideas/syft-bitbucket-pipe/). Pull Requests
should be submitted to the to the Bitbucket reposiotry and changes
will be kept in sync.

## Usage

Basic Usage to generate a SBOM for your current project via a Bitbucket Pipe.
This example will generate a spdx-json SBOM and store it in a file named
`spdx_sbom.json`. The output will be archived to further processing.

```yaml
pipelines:
  default:
    - step:
        name: Build and Test
        caches:
          - node
        script:
          - npm install
          - npm test
    - step:
        name: Generate SBOM
        caches:
          - node
        script:
          - pipe: docker://ccideas/syft-bitbucket-pipe:1.0.0
            variables:
              SYFT_CMD_ARGS: '. --output spdx-json=spdx-sbom.json'
        artifacts:
          - spdx-sbom.json
```

## Variables

| Variable      | Usage                         | Options      | Required |
| --------------| ----------------              | --------     | -------  |
| SYFT_CMD_ARGS | Used to pass in any syft args | <string>     | true     |

## Examples

### Scan your current repo and generate a CycloneDX JSON Formatted SBOM

```SYFT_CMD_ARGS: '. --output cyclonedx-json=sbom-cyclonedx.json'```

### Scan your current repo and generate a SPDX JSON Formatted SBOM

```SYFT_CMD_ARGS: '. --output spdx-json=sbom-spdx.json'```

### Scan a jar file and generate a SPDX JSON Formatted SBOM

```SYFT_CMD_ARGS: '<PATH_TO_JAR_FILE> --output spdx-json=sbom-spdx.json'```

### Scan an archived docker image and generate a SPDX JSON Formatted SBOM

```SYFT_CMD_ARGS: '<PATH_TO_DOCKER_IMAGE_ARCHIVE> --output spdx-json=sbom-spdx.json'```

You can build your SYFT_CMD_ARGS string by reviewing the options available
to you via the ```syft --help``` command.

## Support

If you'd like help with this pipe, or you have an issue, or a feature
request, [let us know](https://github.com/ccideas/syft-bitbucket-pipe/issues).

If you are reporting an issue, please include:

* the version of the pipe
* relevant logs and error messages
* steps to reproduce

## Credits

This Bitbucket pipe is a collection and integration of the following
open source tools

* [syft](https://github.com/anchore/syft?tab=readme-ov-file)

A big thank-you to the teams and volunteers who make these amazing tools available
