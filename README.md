Simple homebrew blog engine using Bash and Kramdown.

Powering my personal homepage at http://lpolzer.com

Usage notes
---
`make.sh` builds, `deploy.sh` uploads.

I use a simple setup with rsync and Apache on a VPS host.

Any markdown file in `posts/` will be picked up and added to the articles section.

Edit the files in `templates/` to adapt the rest of the content to your needs.

Dependencies
---
kramdown, rsync, bash, sed

Colophon
---
CSS and layout inspired by https://github.com/Carpetsmoker/arp242.net
