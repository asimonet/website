# My personal website

This website uses the [Nanoc](http://nanoc.ws/) static website generator with a
set of custom libs, tips and tricks to offer some useful features:

- Automatic generation of a "Publications" pages from a `.bib` file
- Seemless News/blog section with articles written as HTML or Markdown
- Publication of HTML5/CSS3 slides made with Reveal.js, possibly written in
Markdown

## Installing and compiling

To compile the website you must first install Nanoc:

```
$ gem install nanoc
```

To serve the website locally, you must also install _adsf_:
```
$ gem install xxx
$ nanoc view
```

This will serve the website at <http://localhost:3000>.

## Features

Here are details about a few interesting features.

# Publications page

The bibtex file `static/publications/publications.bib` is read to
generate the `/publications/` page automatically.
Publications are sorted by year.

Inside the `.bib` file, a `PDF` key can be added to entries to
provide a download link for the publications:

```
@article{turing1936,
  title={On computable numbers, with an application to the Entscheidungsproblem},
  author={Turing, Alan Mathison},
  journal={J. of Math},
  volume={58},
  number={345-363},
  pages={5},
  year={1936},
  pdf = {/download/turing-computable-numbers.pdf}
}
```

The provided link is relative to `content`.

# News

Nanoc will look for blog articles under `content/news`; this directory
must implement a structure such as the one presented below:

- `2015`
  - `05`
    - `some-html-article.html`
	 - `an-article-written-in-markdown.md`
  - `08`
- `2016`
  - `02`
    - `something-happened.md`

The path to the article will determine the URL to which the page will be
published, _e.g._ the article `2016/02/something-happened.md` will be published
at `/news/2016/02/something-happened/`.

The file extension determines if the article should go through the morkdownn
compiler or not.

The page `/news/` will be automatically created and paginated according to the
`page_size` variable set in `nanoc.yaml`.

An article should follow the following template:

```
---
kind: article
title: The article title
created_at: 2016/02/15
---

This is an abstract
<!--more-->

Here goes the full article...
```

The `created_at` variable in the preamble is used to display the article date
on the webpage and to order the articles by date.

Using the `<!--more-->` marker tells the compiler to display only a portion of
the article (the one before the marker) in the paginated list of articles.

# Reveal.js slides

One interesting features brought by the combination of Nanoc and Reveal.js is
to have slides written in Markdown and compiled with the rest of the slides,
not by the client browser.

For this to work, simply put your slides under a directory called `slides`,
with a `.md` or `.html` extension.  The first lines of each file must provide
the page title and a Reveal.js theme:

```
---
title: The page title
theme: the-theme
---
````
