## Deployment of Application to DASH Development or Production Server

### Server Configuration
The server is configured using git hooks as described [here](http://nicolasgallagher.com/simple-git-deployment-strategy-for-static-sites/). We just have replaced using Makefile with Gulp. There is a remote git repository on HouSuggest and HouSuggestDev, every push to it will be followed by copying the repo into `/srv/www/htdocs/<copy_dir>` which then translates to `www.housuggest.org/<copy_dir` or `hnetdev.hnet.uh.edu/<copy_dir>`.


## Client Configuration - Mac
If you need to setup your Mac for using key based authentication for the git push, please follow in instructions in this nice [blog post](https://matharvard.ca/posts/2011/aug/11/git-push-with-specific-ssh-key/). A sample ssh config file to place in `~/.ssh/` for this step is located [here](https://gist.github.com/CarlSteven/c715c4efbea8117a452f). This will ensure that your local config is compatible with the Gulpfile.

## Client Configuration - Windows
For windows, use Git Bash (located in `C:\Program Files\Git\git-bash.exe` by default) to navigate to `~/.ssh/` and perform steps outlined [in this blog post](https://matharvard.ca/posts/2011/aug/11/git-push-with-specific-ssh-key/) with setting up the SSH config file and pem key files. A sample ssh config file to place in `~/.ssh/` for this step is located [here](https://gist.github.com/CarlSteven/c715c4efbea8117a452f). This will ensure that your local config is compatible with the Gulpfile. 

If needed, please request webadmin SSH keys from @DrDanPrice or @peggylind.

### Pushing to the Staging Environment
1. Navigate to application local repo root. `cd <local_app_repository>`
2. Execute deploy gulp command to staging environment: `gulp deploy-dev` OR to live environment: `gulp deploy-prod`. 
3. Go to website.

If you need a Gulpfile.js, use and modify [this sample one](https://gist.github.com/CarlSteven/39833149163beeb8fd55) and change remote path variables as required. Additionally, add `gulp-deploy-git` and `gulp-clean` to the packages.json npm dependencies.
