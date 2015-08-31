### Deployment of an App as webpage served by Housuggest

We are following an approach using git hooks as described [here](http://nicolasgallagher.com/simple-git-deployment-strategy-for-static-sites/). We created a remote git repository on Housuggest, every push to it will be followed by copying the repo into /srv/www/htdocs/<copy_dir>.

If you need to setup your Mac for using key based authentication for the git -push, please follow in instructions in this nice [blog post](https://matharvard.ca/posts/2011/aug/11/git-push-with-specific-ssh-key/). 

## Pushing to the Staging Environment

1. `cd __[your app here]__`
2. to live environment: `make prod`
   to staging environment: `make staging`
   ----> `cat Makefile` to see information;
   ----> _______.git => housuggest.org/________
3. go to website
4. `make prod`

If you need a Makefile, use and modify the [one from FormBuilder](https://github.com/CarlSteven/FormBuilder/blob/master/Makefile) and change path as required.