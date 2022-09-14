# Docker image for `phpcs`

[![Build Status](https://travis-ci.com/cytopia/docker-phpcs.svg?branch=master)](https://travis-ci.com/cytopia/docker-phpcs)
[![Tag](https://img.shields.io/github/tag/cytopia/docker-phpcs.svg)](https://github.com/cytopia/docker-phpcs/releases)
[![](https://images.microbadger.com/badges/version/cytopia/phpcs:latest.svg?&kill_cache=1)](https://microbadger.com/images/cytopia/phpcs:latest "phpcs")
[![](https://images.microbadger.com/badges/image/cytopia/phpcs:latest.svg?&kill_cache=1)](https://microbadger.com/images/cytopia/phpcs:latest "phpcs")
[![](https://img.shields.io/docker/pulls/cytopia/phpcs.svg)](https://hub.docker.com/r/cytopia/phpcs)
[![](https://img.shields.io/badge/github-cytopia%2Fdocker--phpcs-red.svg)](https://github.com/cytopia/docker-phpcs "github.com/cytopia/docker-phpcs")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)

> #### All [#awesome-ci](https://github.com/topics/awesome-ci) Docker images
>
> [ansible][ansible-git-lnk] **•**
> [ansible-lint][alint-git-lnk] **•**
> [awesome-ci][aci-git-lnk] **•**
> [black][black-git-lnk] **•**
> [checkmake][cm-git-lnk] **•**
> [eslint][elint-git-lnk] **•**
> [file-lint][flint-git-lnk] **•**
> [gofmt][gfmt-git-lnk] **•**
> [goimports][gimp-git-lnk] **•**
> [golint][glint-git-lnk] **•**
> [jsonlint][jlint-git-lnk] **•**
> [linkcheck][linkcheck-git-lnk] **•**
> [mypy][mypy-git-lnk] **•**
> [phpcbf][pcbf-git-lnk] **•**
> [phpcs][pcs-git-lnk] **•**
> [phplint][plint-git-lnk] **•**
> [php-cs-fixer][pcsf-git-lnk] **•**
> [pycodestyle][pycs-git-lnk] **•**
> [pydocstyle][pyds-git-lnk] **•**
> [pylint][pylint-git-lnk] **•**
> [terraform-docs][tfdocs-git-lnk] **•**
> [terragrunt][tg-git-lnk] **•**
> [terragrunt-fmt][tgfmt-git-lnk] **•**
> [yamlfmt][yfmt-git-lnk] **•**
> [yamllint][ylint-git-lnk]

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
| `latest-php8.1` | latest stable         | latest stable `8.1.x` |
| `latest-php8.0` | latest stable         | latest stable `8.0.x` |
| `latest-php7.4` | latest stable         | latest stable `7.4.x` |
| `latest-php7.3` | latest stable         | latest stable `7.3.x` |
| `latest-php7.2` | latest stable         | latest stable `7.2.x` |
| `latest-php7.1` | latest stable         | latest stable `7.1.x` |
| `latest-php7.0` | latest stable         | latest stable `7.0.x` |
| `latest-php5.6` | latest stable         | latest stable `5.6.x` |

#### Latest stable phpcs `3.x.x` version
| Docker tag      | phpcs version         | PHP version           |
|-----------------|-----------------------|-----------------------|
| `3`             | latest stable `3.x.x` | latest stable         |
| `3-php8.1`      | latest stable `3.x.x` | latest stable `8.1.x` |
| `3-php8.0`      | latest stable `3.x.x` | latest stable `8.0.x` |
| `3-php7.4`      | latest stable `3.x.x` | latest stable `7.4.x` |
| `3-php7.3`      | latest stable `3.x.x` | latest stable `7.3.x` |
| `3-php7.2`      | latest stable `3.x.x` | latest stable `7.2.x` |
| `3-php7.1`      | latest stable `3.x.x` | latest stable `7.1.x` |
| `3-php7.0`      | latest stable `3.x.x` | latest stable `7.0.x` |
| `3-php5.6`      | latest stable `3.x.x` | latest stable `5.6.x` |

#### Latest stable phpcs `2.x.x` version
| Docker tag      | phpcs version         | PHP version           |
|-----------------|-----------------------|-----------------------|
| `2`             | latest stable `2.x.x` | latest stable         |
| `2-php7.4`      | latest stable `2.x.x` | latest stable `7.4.x` |
| `2-php7.3`      | latest stable `2.x.x` | latest stable `7.3.x` |
| `2-php7.2`      | latest stable `2.x.x` | latest stable `7.2.x` |
| `2-php7.1`      | latest stable `2.x.x` | latest stable `7.1.x` |
| `2-php7.0`      | latest stable `2.x.x` | latest stable `7.0.x` |
| `2-php5.6`      | latest stable `2.x.x` | latest stable `5.6.x` |


## Docker mounts

The working directory inside the Docker container is **`/data/`** and should be mounted locally to
the root of your project.


## Usage

### Basic
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

### Custom standard
Custom standards must be mounted inside the container to `/usr/bin/CodeSniffer.conf `
```bash
# Via command line
$ docker run --rm -v $(pwd):/data -v CodeSniffer.conf:/usr/bin/CodeSniffer.conf cytopia/phpcs .
```
```yaml
# Docker compose
phpcs:
  image: cytopia/phpcs
  volumes:
    - .:/data
    - CodeSniffer.conf:/usr/bin/CodeSniffer.conf
```


## Related [#awesome-ci](https://github.com/topics/awesome-ci) projects

### Docker images

Save yourself from installing lot's of dependencies and pick a dockerized version of your favourite
linter below for reproducible local or remote CI tests:

| GitHub | DockerHub | Type | Description |
|--------|-----------|------|-------------|
| [awesome-ci][aci-git-lnk]        | [![aci-hub-img]][aci-hub-lnk]         | Basic      | Tools for git, file and static source code analysis |
| [file-lint][flint-git-lnk]       | [![flint-hub-img]][flint-hub-lnk]     | Basic      | Baisc source code analysis |
| [linkcheck][linkcheck-git-lnk]   | [![linkcheck-hub-img]][flint-hub-lnk] | Basic      | Search for URLs in files and validate their HTTP status code |
| [ansible][ansible-git-lnk]       | [![ansible-hub-img]][ansible-hub-lnk] | Ansible    | Multiple versions and flavours of Ansible |
| [ansible-lint][alint-git-lnk]    | [![alint-hub-img]][alint-hub-lnk]     | Ansible    | Lint Ansible |
| [gofmt][gfmt-git-lnk]            | [![gfmt-hub-img]][gfmt-hub-lnk]       | Go         | Format Go source code **<sup>[1]</sup>** |
| [goimports][gimp-git-lnk]        | [![gimp-hub-img]][gimp-hub-lnk]       | Go         | Format Go source code **<sup>[1]</sup>** |
| [golint][glint-git-lnk]          | [![glint-hub-img]][glint-hub-lnk]     | Go         | Lint Go code |
| [eslint][elint-git-lnk]          | [![elint-hub-img]][elint-hub-lnk]     | Javascript | Lint Javascript code |
| [jsonlint][jlint-git-lnk]        | [![jlint-hub-img]][jlint-hub-lnk]     | JSON       | Lint JSON files **<sup>[1]</sup>** |
| [checkmake][cm-git-lnk]          | [![cm-hub-img]][cm-hub-lnk]           | Make       | Lint Makefiles |
| [phpcbf][pcbf-git-lnk]           | [![pcbf-hub-img]][pcbf-hub-lnk]       | PHP        | PHP Code Beautifier and Fixer |
| [phpcs][pcs-git-lnk]             | [![pcs-hub-img]][pcs-hub-lnk]         | PHP        | PHP Code Sniffer |
| [phplint][plint-git-lnk]         | [![plint-hub-img]][plint-hub-lnk]     | PHP        | PHP Code Linter **<sup>[1]</sup>** |
| [php-cs-fixer][pcsf-git-lnk]     | [![pcsf-hub-img]][pcsf-hub-lnk]       | PHP        | PHP Coding Standards Fixer |
| [black][black-git-lnk]           | [![black-hub-img]][black-hub-lnk]     | Python     | The uncompromising Python code formatter |
| [mypy][mypy-git-lnk]             | [![mypy-hub-img]][mypy-hub-lnk]       | Python     | Static source code analysis |
| [pycodestyle][pycs-git-lnk]      | [![pycs-hub-img]][pycs-hub-lnk]       | Python     | Python style guide checker |
| [pydocstyle][pyds-git-lnk]       | [![pyds-hub-img]][pyds-hub-lnk]       | Python     | Python docstyle checker |
| [pylint][pylint-git-lnk]         | [![pylint-hub-img]][pylint-hub-lnk]   | Python     | Python source code, bug and quality checker |
| [terraform-docs][tfdocs-git-lnk] | [![tfdocs-hub-img]][tfdocs-hub-lnk]   | Terraform  | Terraform doc generator (TF 0.12 ready) **<sup>[1]</sup>** |
| [terragrunt][tg-git-lnk]         | [![tg-hub-img]][tg-hub-lnk]           | Terraform  | Terragrunt and Terraform |
| [terragrunt-fmt][tgfmt-git-lnk]  | [![tgfmt-hub-img]][tgfmt-hub-lnk]     | Terraform  | `terraform fmt` for Terragrunt files **<sup>[1]</sup>** |
| [yamlfmt][yfmt-git-lnk]          | [![yfmt-hub-img]][yfmt-hub-lnk]       | Yaml       | Format Yaml files **<sup>[1]</sup>** |
| [yamllint][ylint-git-lnk]        | [![ylint-hub-img]][ylint-hub-lnk]     | Yaml       | Lint Yaml files |

> **<sup>[1]</sup>** Uses a shell wrapper to add **enhanced functionality** not available by original project.

[aci-git-lnk]: https://github.com/cytopia/awesome-ci
[aci-hub-img]: https://img.shields.io/docker/pulls/cytopia/awesome-ci.svg
[aci-hub-lnk]: https://hub.docker.com/r/cytopia/awesome-ci

[flint-git-lnk]: https://github.com/cytopia/docker-file-lint
[flint-hub-img]: https://img.shields.io/docker/pulls/cytopia/file-lint.svg
[flint-hub-lnk]: https://hub.docker.com/r/cytopia/file-lint

[linkcheck-git-lnk]: https://github.com/cytopia/docker-linkcheck
[linkcheck-hub-img]: https://img.shields.io/docker/pulls/cytopia/linkcheck.svg
[linkcheck-hub-lnk]: https://hub.docker.com/r/cytopia/linkcheck

[jlint-git-lnk]: https://github.com/cytopia/docker-jsonlint
[jlint-hub-img]: https://img.shields.io/docker/pulls/cytopia/jsonlint.svg
[jlint-hub-lnk]: https://hub.docker.com/r/cytopia/jsonlint

[ansible-git-lnk]: https://github.com/cytopia/docker-ansible
[ansible-hub-img]: https://img.shields.io/docker/pulls/cytopia/ansible.svg
[ansible-hub-lnk]: https://hub.docker.com/r/cytopia/ansible

[alint-git-lnk]: https://github.com/cytopia/docker-ansible-lint
[alint-hub-img]: https://img.shields.io/docker/pulls/cytopia/ansible-lint.svg
[alint-hub-lnk]: https://hub.docker.com/r/cytopia/ansible-lint

[gfmt-git-lnk]: https://github.com/cytopia/docker-gofmt
[gfmt-hub-img]: https://img.shields.io/docker/pulls/cytopia/gofmt.svg
[gfmt-hub-lnk]: https://hub.docker.com/r/cytopia/gofmt

[gimp-git-lnk]: https://github.com/cytopia/docker-goimports
[gimp-hub-img]: https://img.shields.io/docker/pulls/cytopia/goimports.svg
[gimp-hub-lnk]: https://hub.docker.com/r/cytopia/goimports

[glint-git-lnk]: https://github.com/cytopia/docker-golint
[glint-hub-img]: https://img.shields.io/docker/pulls/cytopia/golint.svg
[glint-hub-lnk]: https://hub.docker.com/r/cytopia/golint

[elint-git-lnk]: https://github.com/cytopia/docker-eslint
[elint-hub-img]: https://img.shields.io/docker/pulls/cytopia/eslint.svg
[elint-hub-lnk]: https://hub.docker.com/r/cytopia/eslint

[cm-git-lnk]: https://github.com/cytopia/docker-checkmake
[cm-hub-img]: https://img.shields.io/docker/pulls/cytopia/checkmake.svg
[cm-hub-lnk]: https://hub.docker.com/r/cytopia/checkmake

[pcbf-git-lnk]: https://github.com/cytopia/docker-phpcbf
[pcbf-hub-img]: https://img.shields.io/docker/pulls/cytopia/phpcbf.svg
[pcbf-hub-lnk]: https://hub.docker.com/r/cytopia/phpcbf

[pcs-git-lnk]: https://github.com/cytopia/docker-phpcs
[pcs-hub-img]: https://img.shields.io/docker/pulls/cytopia/phpcs.svg
[pcs-hub-lnk]: https://hub.docker.com/r/cytopia/phpcs

[plint-git-lnk]: https://github.com/cytopia/docker-phplint
[plint-hub-img]: https://img.shields.io/docker/pulls/cytopia/phplint.svg
[plint-hub-lnk]: https://hub.docker.com/r/cytopia/phplint

[pcsf-git-lnk]: https://github.com/cytopia/docker-php-cs-fixer
[pcsf-hub-img]: https://img.shields.io/docker/pulls/cytopia/php-cs-fixer.svg
[pcsf-hub-lnk]: https://hub.docker.com/r/cytopia/php-cs-fixer

[black-git-lnk]: https://github.com/cytopia/docker-black
[black-hub-img]: https://img.shields.io/docker/pulls/cytopia/black.svg
[black-hub-lnk]: https://hub.docker.com/r/cytopia/black

[mypy-git-lnk]: https://github.com/cytopia/docker-mypy
[mypy-hub-img]: https://img.shields.io/docker/pulls/cytopia/mypy.svg
[mypy-hub-lnk]: https://hub.docker.com/r/cytopia/mypy

[pycs-git-lnk]: https://github.com/cytopia/docker-pycodestyle
[pycs-hub-img]: https://img.shields.io/docker/pulls/cytopia/pycodestyle.svg
[pycs-hub-lnk]: https://hub.docker.com/r/cytopia/pycodestyle

[pyds-git-lnk]: https://github.com/cytopia/docker-pydocstyle
[pyds-hub-img]: https://img.shields.io/docker/pulls/cytopia/pydocstyle.svg
[pyds-hub-lnk]: https://hub.docker.com/r/cytopia/pydocstyle

[pylint-git-lnk]: https://github.com/cytopia/docker-pylint
[pylint-hub-img]: https://img.shields.io/docker/pulls/cytopia/pylint.svg
[pylint-hub-lnk]: https://hub.docker.com/r/cytopia/pylint

[tfdocs-git-lnk]: https://github.com/cytopia/docker-terraform-docs
[tfdocs-hub-img]: https://img.shields.io/docker/pulls/cytopia/terraform-docs.svg
[tfdocs-hub-lnk]: https://hub.docker.com/r/cytopia/terraform-docs

[tg-git-lnk]: https://github.com/cytopia/docker-terragrunt
[tg-hub-img]: https://img.shields.io/docker/pulls/cytopia/terragrunt.svg
[tg-hub-lnk]: https://hub.docker.com/r/cytopia/terragrunt

[tgfmt-git-lnk]: https://github.com/cytopia/docker-terragrunt-fmt
[tgfmt-hub-img]: https://img.shields.io/docker/pulls/cytopia/terragrunt-fmt.svg
[tgfmt-hub-lnk]: https://hub.docker.com/r/cytopia/terragrunt-fmt

[yfmt-git-lnk]: https://github.com/cytopia/docker-yamlfmt
[yfmt-hub-img]: https://img.shields.io/docker/pulls/cytopia/yamlfmt.svg
[yfmt-hub-lnk]: https://hub.docker.com/r/cytopia/yamlfmt

[ylint-git-lnk]: https://github.com/cytopia/docker-yamllint
[ylint-hub-img]: https://img.shields.io/docker/pulls/cytopia/yamllint.svg
[ylint-hub-lnk]: https://hub.docker.com/r/cytopia/yamllint


### Makefiles

Visit **[cytopia/makefiles](https://github.com/cytopia/makefiles)** for dependency-less, seamless project integration and minimum required best-practice code linting for CI.
The provided Makefiles will only require GNU Make and Docker itself removing the need to install anything else.


## License

**[MIT License](LICENSE)**

Copyright (c) 2019 [cytopia](https://github.com/cytopia)
