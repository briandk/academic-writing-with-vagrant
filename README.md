# academic-writing-with-vagrant
An entire vagrant VM for portably compiling RMarkdown files. Useful for when you need to collaborate over a manuscript and you want to make sure everyone has a dependency-managed way to compile the manuscript.

# Installation

Copy and paste this into your terminal, then hit Enter

```bash
curl -O https://rawgit.com/briandk/academic-writing-with-vagrant/master/makefile
curl -O https://rawgit.com/briandk/academic-writing-with-vagrant/master/Vagrantfile
curl -O https://rawgit.com/briandk/academic-writing-with-vagrant/master/render_manuscript.R
curl -O https://rawgit.com/briandk/academic-writing-with-vagrant/master/r-dependencies.R
curl -O https://rawgit.com/briandk/academic-writing-with-vagrant/master/bootstrap.sh
vagrant up

```
