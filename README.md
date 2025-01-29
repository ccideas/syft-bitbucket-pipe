# ShiftSBOMGen

[![SonarQube Cloud](https://sonarcloud.io/images/project_badges/sonarcloud-highlight.svg)](https://sonarcloud.io/summary/new_code?id=ccideas1_syft-pipe)

[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=ccideas1_syft-pipe&metric=bugs)](https://sonarcloud.io/summary/new_code?id=ccideas1_syft-pipe)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=ccideas1_syft-pipe&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=ccideas1_syft-pipe)
[![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=ccideas1_syft-pipe&metric=duplicated_lines_density)](https://sonarcloud.io/summary/new_code?id=ccideas1_syft-pipe)


![Build Badge](https://img.shields.io/bitbucket/pipelines/ccideas1/syft-pipe/main)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/shiftleftcyber/syft-bitbucket-pipe)

ShiftSBOMGen is a pure client-side Bitbucket Pipe that generates a Software Bill of Materials (SBOM). ShiftSBOMGen
supports both CycloneDX & SPDX Standards and supports a wide range of ecosystems and container types. 
No subscriptions, server access, or API keys are required to use this Pipe

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
          - pipe: docker://ccideas/syft-bitbucket-pipe:1.2.0
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
