![Build Status](https://gitlab.com/pages/hugo/badges/master/build.svg)

---

Example [Hugo] website using GitLab Pages.

Learn more about GitLab Pages at https://pages.gitlab.io and the official
documentation https://docs.gitlab.com/ce/user/project/pages/.

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [GitLab CI](#gitlab-ci)
- [Building locally](#building-locally)
- [GitLab User or Group Pages](#gitlab-user-or-group-pages)
- [Did you fork this project?](#did-you-fork-this-project)
- [Troubleshooting](#troubleshooting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## GitLab CI

This project's static Pages are built by [GitLab CI][ci], following the steps
defined in [`.gitlab-ci.yml`](.gitlab-ci.yml).

## Building locally

To work locally with this project, you'll have to follow the steps below:

1. Fork, clone or download this project
1. [Install][] Hugo
1. Preview your project: `hugo server`.
1. Add content.
1. Generate the website: `hugo` (optional)

Read more at Hugo's [documentation][].

## Use a custom theme

To use a custom theme:

1. Visit <https://themes.gohugo.io/> and pick the theme you want to use.
1. Uncomment the following lines from `.gitlab-ci.yml`, replacing `<theme_url>`
   with the URL of the theme you chose:

   ```yaml
   - svn export <theme_url> themes/<theme_name>
   ```

1. Edit `config.toml` and add the theme:

   ```plaintext
   theme = "themes/<theme_name>"
   ```

## `hugo` vs `hugo_extended`

The [Container Registry](https://gitlab.com/pages/hugo/container_registry)
contains two kinds of Hugo Docker images, `hugo` and
`hugo_extended`. Their main difference is that `hugo_extended` comes with
Sass/SCSS support. If you don't know if your theme supports it, it's safe to
use `hugo_extended` since it's a superset of `hugo`.

The Container Registry contains three repositories:

- `registry.gitlab.com/pages/hugo`
- `registry.gitlab.com/pages/hugo/hugo`
- `registry.gitlab.com/pages/hugo/hugo_extended`

`pages/hugo:<version>` and `pages/hugo/hugo:<version>` are effectively the same.
`hugo_extended` was created afterwards, so we had to create the `pages/hugo/` namespace.

See [how the images are built and deployed](https://gitlab.com/pages/hugo/-/blob/707b8e367cdea5dbf471ff5bbec9f684ae51de79/.gitlab-ci.yml#L36-47).

## GitLab User or Group Pages

To use this project as your user/group website, you will need one additional
step: just rename your project to `namespace.gitlab.io`, where `namespace` is
your `username` or `groupname`. This can be done by navigating to your
project's **Settings**.

You'll need to configure your site too: change this line
in your `config.toml`, from `"https://pages.gitlab.io/hugo/"` to `baseurl = "https://namespace.gitlab.io"`.
Proceed equally if you are using a [custom domain][post]: `baseurl = "http(s)://example.com"`.

Read more about [user/group Pages][userpages] and [project Pages][projpages].

## Did you fork this project?

If you forked this project for your own use, please go to your project's
**Settings** and remove the forking relationship, which won't be necessary
unless you want to contribute back to the upstream project.

## Troubleshooting

1. CSS is missing! That means two things:

    Either that you have wrongly set up the CSS URL in your templates, or
    your static generator has a configuration option that needs to be explicitly
    set in order to serve static assets under a relative URL.

[ci]: https://about.gitlab.com/gitlab-ci/
[hugo]: https://gohugo.io
[install]: https://gohugo.io/overview/installing/
[documentation]: https://gohugo.io/overview/introduction/
[userpages]: http://doc.gitlab.com/ee/pages/README.html#user-or-group-pages
[projpages]: http://doc.gitlab.com/ee/pages/README.html#project-pages
[post]: https://about.gitlab.com/2016/04/07/gitlab-pages-setup/#custom-domains
