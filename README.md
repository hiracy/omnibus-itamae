itamae Omnibus project
======================

This project creates full-stack platform-specific packages for
`itamae`!

Pre-built Packages
------------------

### Ubuntu 14.04 (trusty)

[ ![Download](https://api.bintray.com/packages/itamae/itamae/itamae/images/download.svg) ](https://bintray.com/itamae/itamae/itamae/_latestVersion)

```
$ echo 'deb https://dl.bintray.com/itamae/itamae trusty contrib' | sudo tee /etc/apt/sources.list.d/itamae.list
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv D401AB61
$ sudo apt-get update
$ sudo apt-get install itamae
```

### CentOS 7

[ ![Download](https://api.bintray.com/packages/itamae/itamae-rpm/itamae/images/download.svg) ](https://bintray.com/itamae/itamae-rpm/itamae/_latestVersion)

```
$ wget https://bintray.com/itamae/itamae-rpm/rpm -O bintray-itamae-itamae-rpm.repo
$ sudo mv bintray-itamae-itamae-rpm.repo /etc/yum.repos.d/
```

Installation
------------
You must have a sane Ruby 1.9+ environment with Bundler installed. Ensure all
the required gems are installed:

```shell
$ bundle install --binstubs
```

Usage
-----
### Build

You create a platform-specific package using the `build project` command:

```shell
$ bin/omnibus build itamae
```

The platform/architecture type of the package created will match the platform
where the `build project` command is invoked. For example, running this command
on a MacBook Pro will generate a Mac OS X package. After the build completes
packages will be available in the `pkg/` folder.

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ bin/omnibus clean itamae
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/itamae`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ bin/omnibus clean itamae --purge
```

### Publish

Omnibus has a built-in mechanism for releasing to a variety of "backends", such
as Amazon S3. You must set the proper credentials in your `omnibus.rb` config
file or specify them via the command line.

```shell
$ bin/omnibus publish path/to/*.deb --backend s3
```

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

```shell
$ bin/omnibus help
```

Kitchen-based Build Environment
-------------------------------
Every Omnibus project ships will a project-specific
[Berksfile](http://berkshelf.com/) that will allow you to build your omnibus projects on all of the projects listed
in the `.kitchen.yml`. You can add/remove additional platforms as needed by
changing the list found in the `.kitchen.yml` `platforms` YAML stanza.

This build environment is designed to get you up-and-running quickly. However,
there is nothing that restricts you to building on other platforms. Simply use
the [omnibus cookbook](https://github.com/opscode-cookbooks/omnibus) to setup
your desired platform and execute the build steps listed above.

The default build environment requires Test Kitchen and VirtualBox for local
development. Test Kitchen also exposes the ability to provision instances using
various cloud providers like AWS, DigitalOcean, or OpenStack. For more
information, please see the [Test Kitchen documentation](http://kitchen.ci).

Once you have tweaked your `.kitchen.yml` (or `.kitchen.local.yml`) to your
liking, you can bring up an individual build environment using the `kitchen`
command.

```shell
$ bin/kitchen converge ubuntu-1204
```

Then login to the instance and build the project as described in the Usage
section:

```shell
$ bundle exec kitchen login ubuntu-1204
[vagrant@ubuntu...] $ cd itamae
[vagrant@ubuntu...] $ bundle install
[vagrant@ubuntu...] $ ...
[vagrant@ubuntu...] $ bin/omnibus build itamae
```

For a complete list of all commands and platforms, run `kitchen list` or
`kitchen help`.
