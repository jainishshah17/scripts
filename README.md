# Bitbucket Pipelines Pipe: Artifactory Maven

This pipe triggers a Maven build, while resolving Maven dependencies and deploying Maven packages from and to Artifactory.

By default, this pipe will also capture build-info and publish it to Artifactory as metadata associated with the built artifacts.

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
- pipe: JfrogDev/artifactory-maven:0.0.1
  variables:
    ARTIFACTORY_URL: "<string>"
    ARTIFACTORY_USER: "<string>"
    ARTIFACTORY_PASSWORD: "<string>"
    MAVEN_SNAPSHOT_REPO: "<string>"
    # MAVEN_COMMAND: "<string>"
    # BUILD_NAME: "<string>" # Optional.
    # BUILD_NAME: "<string>" # Optional.
    # JFROG_CLI_TEMP_DIR: "<string>" # Optional.
    # JFROG_CLI_HOME_DIR: "<string>" # Optional.
    # COLLECT_ENV: "<boolean>" # Optional.
    # COLLECT_BUILD_INFO: "<boolean>" # Optional.
    # FOLDER: "<string>" # Optional.
    # EXTRA_ARGS: "<string>" # Optional.
    # DEBUG: "<boolean>" # Optional.
```

## Variables

| Variable        | Usage                                     |
| --------------  | ----------------------------------------- |
| ARTIFACTORY_URL (\*)  | The JFrog Artifactory URL . |
| ARTIFACTORY_USER (\*)  | Artifactory User with permission to create and access artifacts.   |
| ARTIFACTORY_PASSWORD (\*)  | Password for Artifactory User. |
| MAVEN_SNAPSHOT_REPO (\*)  | Artifactory Maven repository that will be used to resolve snapshots. |
| MAVEN_RELEASE_REPO (\*)  | Artifactory Maven repository that will be used to resolve releases. |
| MAVEN_COMMAND (\*)  | Maven command to execute. default `clean install` |
| BUILD_NAME (\*) | Build Name. Default: `$BITBUCKET_REPO_OWNER-$BITBUCKET_REPO_SLUG-$BITBUCKET_BRANCH` |
| JFROG_CLI_TEMP_DIR (\*)  | Specifies the JFrog CLI temp directory. Default: `.` |
| JFROG_CLI_HOME_DIR (\*)  | Specifies the JFrog CLI home directory.Default: `.` |
| COLLECT_ENV (\*)  | This flag is used to collect environment variables and attach them to a build. Default: `true` |
| COLLECT_BUILD_INFO (\*)  | This flag is used to publish build info to Artifactory. Default: `true` |
| FOLDER          | A folder containing the `package.json` file. Default to the current directory: `.` |
| EXTRA_ARGS      | Extra arguments to be passed to the JFrog CLI command (see [JFrog CLI docs](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory) for more details). Defaults to unset. |
| DEBUG           | Set to _true_ to output additional debug information. Default: `false`. |

_(\*) = required variable._

## Prerequisites

JFrog Artifactory details are necessary to use this pipe.

- Add the Credentials as a [secured environment variable](https://confluence.atlassian.com/x/0CVbLw#Environmentvariables-Securedvariables) in Bitbucket Pipelines.

## Examples

### Basic example 

Publishes Maven packages to Artifactory.

```yaml
script:
  - pipe: JfrogDev/artifactory-maven:0.0.1
    variables:
      ARTIFACTORY_URL: "<string>"
      ARTIFACTORY_USER: "<string>"
      ARTIFACTORY_PASSWORD: "<string>"
      MAVEN_SNAPSHOT_REPO: "<string>"
      MAVEN_RELEASE_REPO: "<string>"
```

### Advanced example 
Publishes Maven packages from the `app` directory to Artifactory. 

```yaml
script:
  - pipe: JfrogDev/artifactory-maven:0.0.1
    variables:
      ARTIFACTORY_URL: "<string>"
      ARTIFACTORY_USER: "<string>"
      ARTIFACTORY_PASSWORD: "<string>"
      MAVEN_SNAPSHOT_REPO: "<string>"
      MAVEN_RELEASE_REPO: "<string>"
      MAVEN_COMMAND: "clean test install"
      FOLDER: "app"
```

## Support
If you'd like help with this pipe, or you have an issue or feature request, [let us know on community][community].

If you're reporting an issue, please include:

* the version of the pipe
* relevant logs and error messages
* steps to reproduce

## License
Apache 2.0 licensed, see [LICENSE](LICENSE) file.
