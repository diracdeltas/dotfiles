When building a web app, prefer static HTML that can be deployed on GitHub
pages without using actions. Always start with the most
restrictive content security policy possible, and do not use inline scripts or
styles. Prefer NodeJS over Python but always prefer less dependencies.
Assume all repos will be open sourced at some point, so don't commit sensitive
non-public info.
