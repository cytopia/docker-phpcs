# Docker image for `phpcs`

[![Build Status](https://travis-ci.com/cytopia/docker-phpcs.svg?branch=master)](https://travis-ci.com/cytopia/docker-phpcs)
[![Tag](https://img.shields.io/github/tag/cytopia/docker-phpcs.svg)](https://github.com/cytopia/docker-phpcs/releases)
[![](https://images.microbadger.com/badges/version/cytopia/phpcs:latest.svg?&kill_cache=1)](https://microbadger.com/images/cytopia/phpcs:latest "phpcs")
[![](https://images.microbadger.com/badges/image/cytopia/phpcs:latest.svg?&kill_cache=1)](https://microbadger.com/images/cytopia/phpcs:latest "phpcs")
[![](https://img.shields.io/badge/github-cytopia%2Fdocker--phpcs-red.svg)](https://github.com/cytopia/docker-phpcs "github.com/cytopia/docker-phpcs")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)

> #### All [#awesome-ci](https://github.com/topics/awesome-ci) Docker images
>
> [ansible](https://github.com/cytopia/docker-ansible) **•**
> [ansible-lint](https://github.com/cytopia/docker-ansible-lint) **•**
> [awesome-ci](https://github.com/cytopia/awesome-ci) **•**
> [black](https://github.com/cytopia/docker-black) **•**
> [checkmake](https://github.com/cytopia/docker-checkmake) **•**
> [eslint](https://github.com/cytopia/docker-eslint) **•**
> [file-lint](https://github.com/cytopia/docker-file-lint) **•**
> [gofmt](https://github.com/cytopia/docker-gofmt) **•**
> [goimports](https://github.com/cytopia/docker-phpcs) **•**
> [golint](https://github.com/cytopia/docker-golint) **•**
> [jsonlint](https://github.com/cytopia/docker-jsonlint) **•**
> [phpcbf](https://github.com/cytopia/docker-phpcbf) **•**
> [phpcs](https://github.com/cytopia/docker-phpcs) **•**
> [php-cs-fixer](https://github.com/cytopia/docker-php-cs-fixer) **•**
> [pycodestyle](https://github.com/cytopia/docker-pycodestyle) **•**
> [pylint](https://github.com/cytopia/docker-pylint) **•**
> [terraform-docs](https://github.com/cytopia/docker-terraform-docs) **•**
> [terragrunt](https://github.com/cytopia/docker-terragrunt) **•**
> [yamllint](https://github.com/cytopia/docker-yamllint)


> #### All [#awesome-ci](https://github.com/topics/awesome-ci) Makefiles
>
> Visit **[cytopia/makefiles](https://github.com/cytopia/makefiles)** for seamless project integration, minimum required best-practice code linting and CI.

View **[Dockerfile](https://github.com/cytopia/docker-phpcs/blob/master/Dockerfile)** on GitHub.

[![Docker hub](http://dockeri.co/image/cytopia/phpcs?&kill_cache=1)](https://hub.docker.com/r/cytopia/phpcs)

Tiny Alpine-based multistage-builld dockerized version of [phpcs](https://github.com/squizlabs/PHP_CodeSniffer)<sup>[1]</sup>.
The image is built nightly against multiple stable versions and pushed to Dockerhub.

<sup>[1] Official project: https://github.com/squizlabs/PHP_CodeSniffer</sup>


## Available Docker image versions

Docker images for PHP CodeSniffer come with all available PHP versions. In doubt use `latest` tag.

#### Latest stable phpcs version
| Docker tag      | phpcs version         | PHP version           |
|-----------------|-----------------------|-----------------------|
| `latest`        | latest stable         | latest stable         |
| `latest-php7.3` | latest stable         | latest stable `7.3.x` |
| `latest-php7.2` | latest stable         | latest stable `7.2.x` |
| `latest-php7.1` | latest stable         | latest stable `7.1.x` |
| `latest-php7.0` | latest stable         | latest stable `7.0.x` |
| `latest-php5.6` | latest stable         | latest stable `5.6.x` |

#### Latest stable phpcs `3.x.x` version
| Docker tag      | phpcs version         | PHP version           |
|-----------------|-----------------------|-----------------------|
| `3`             | latest stable `3.x.x` | latest stable         |
| `3-php7.3`      | latest stable `3.x.x` | latest stable `7.3.x` |
| `3-php7.2`      | latest stable `3.x.x` | latest stable `7.2.x` |
| `3-php7.1`      | latest stable `3.x.x` | latest stable `7.1.x` |
| `3-php7.0`      | latest stable `3.x.x` | latest stable `7.0.x` |
| `3-php5.6`      | latest stable `3.x.x` | latest stable `5.6.x` |

#### Latest stable phpcs `2.x.x` version
| Docker tag      | phpcs version         | PHP version           |
|-----------------|-----------------------|-----------------------|
| `2`             | latest stable `2.x.x` | latest stable         |
| `2-php7.3`      | latest stable `2.x.x` | latest stable `7.3.x` |
| `2-php7.2`      | latest stable `2.x.x` | latest stable `7.2.x` |
| `2-php7.1`      | latest stable `2.x.x` | latest stable `7.1.x` |
| `2-php7.0`      | latest stable `2.x.x` | latest stable `7.0.x` |
| `2-php5.6`      | latest stable `2.x.x` | latest stable `5.6.x` |


## Docker mounts

The working directory inside the Docker container is **`/data/`** and should be mounted locally to
the root of your project.


## Usage


```bash
$ docker run --rm -v $(pwd):/data cytopia/phpcs .

----------------------------------------------------------------------
FOUND 4 ERRORS AFFECTING 3 LINES
----------------------------------------------------------------------
 2 | ERROR | [ ] Missing file doc comment
 5 | ERROR | [x] First condition of a multi-line IF statement must
   |       |     directly follow the opening parenthesis
 6 | ERROR | [x] Line indented incorrectly; expected at least 4
   |       |     spaces, found 1
 6 | ERROR | [x] Closing brace must be on a line by itself
----------------------------------------------------------------------
PHPCBF CAN FIX THE 3 MARKED SNIFF VIOLATIONS AUTOMATICALLY
----------------------------------------------------------------------
```


## Related [#awesome-ci](https://github.com/topics/awesome-ci) projects

### Docker images

Save yourself from installing lot's of dependencies and pick a dockerized version of your favourite
linter below for reproducible local or remote CI tests:

| Docker image | Type | Description |
|--------------|------|-------------|
| [awesome-ci](https://github.com/cytopia/awesome-ci) | Basic | Tools for git, file and static source code analysis |
| [file-lint](https://github.com/cytopia/docker-file-lint) | Basic | Baisc source code analysis |
| [jsonlint](https://github.com/cytopia/docker-jsonlint) | Basic | Lint JSON files **<sup>[1]</sup>** |
| [yamllint](https://github.com/cytopia/docker-yamllint) | Basic | Lint Yaml files |
| [ansible](https://github.com/cytopia/docker-ansible) | Ansible | Multiple versoins of Ansible |
| [ansible-lint](https://github.com/cytopia/docker-ansible-lint) | Ansible | Lint  Ansible |
| [gofmt](https://github.com/cytopia/docker-gofmt) | Go | Format Go source code **<sup>[1]</sup>** |
| [goimports](https://github.com/cytopia/docker-phpcs) | Go | Format Go source code **<sup>[1]</sup>** |
| [golint](https://github.com/cytopia/docker-golint) | Go | Lint Go code |
| [eslint](https://github.com/cytopia/docker-eslint) | Javascript | Lint Javascript code |
| [checkmake](https://github.com/cytopia/docker-checkmake) | Make | Lint Makefiles |
| [phpcbf](https://github.com/cytopia/docker-phpcbf) | PHP | PHP Code Beautifier and Fixer |
| [phpcs](https://github.com/cytopia/docker-phpcs) | PHP | PHP Code Sniffer |
| [php-cs-fixer](https://github.com/cytopia/docker-php-cs-fixer) | PHP | PHP Coding Standards Fixer |
| [black](https://github.com/cytopia/docker-black) | Python | The uncompromising Python code formatter |
| [pycodestyle](https://github.com/cytopia/docker-pycodestyle) | Python | Python style guide checker |
| [pylint](https://github.com/cytopia/docker-pylint) | Python | Python source code, bug and quality checker |
| [terraform-docs](https://github.com/cytopia/docker-terraform-docs) | Terraform | Terraform doc generator (TF 0.12 ready) **<sup>[1]</sup>** |
| [terragrunt](https://github.com/cytopia/docker-terragrunt) | Terraform | Terragrunt and Terraform |

> **<sup>[1]</sup>** Uses a shell wrapper to add **enhanced functionality** not available by original project.


### Makefiles

Visit **[cytopia/makefiles](https://github.com/cytopia/makefiles)** for dependency-less, seamless project integration and minimum required best-practice code linting for CI.
The provided Makefiles will only require GNU Make and Docker itself removing the need to install anything else.


## License

**[MIT License](LICENSE)**

Copyright (c) 2019 [cytopia](https://github.com/cytopia)
