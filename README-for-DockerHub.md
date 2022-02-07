# yo-buildabanner

This image containerized [Yeoman](https://yeoman.io/) and the [Buildabanner Generator](https://github.com/johnfmorton/generator-buildabanner). It is currently in _beta_ and your feedback is welcome. You can post issues at the [GitHub page issues page](https://github.com/johnfmorton/docker-build-a-banner/issues).

## How to use the image

The default command for the image, `/bin/sh`, is give you a shell prompt. The shell prompt is how you interact with Build A Banner (BAB).

### Step 1

From your terminal, navigate to an empty directory you want to build your banner in. Then enter:

```
docker container run -p 8080:8080/tcp -p 35729:35729/tcp -v "$PWD":/app -it --rm johnfmorton/yo-buildabanner:beta
```

If that seems like too much to remember, I agree! That's why I have it hidden behind an alias like this. This will go in your `rc` file, for example your `.bashrc` if you use bash, or `.zshrc` if you use zsh.

```
alias banner='docker container run -p 8080:8080/tcp -p 35729:35729/tcp -v "$PWD":/app -it --rm johnfmorton/yo-buildabanner:beta'
```

With the alias, you can just type `banner` to start the Docker container. The exposed ports are for the development server, port 8080, and it's live reload service, port 35729.

I also keep another alias that will update the image. The only difference is the addtional `--pull always` flag. There is no option to only pull when the image is updated, so you must check manually.

```
alias bannerupdate='docker container run -p 8080:8080 -p 35729:35729 -v "$PWD":/app -it --pull always --rm johnfmorton/yo-buildabanner:beta'
```

### Step 2

You are now inside the container. To create your banner, tell Yeoman to use the Build A Banner generator.

```
yo buildabanner
```

You will now be presented with a series of prompts to customize what you are building. Once you're answered the questions, a series of node modules will be installed in your directory.

### Step 3

To start the dev server, type in `gulp` which will result in many lines of text to scroll through your terminal. Keep an eye on this text to know when the server is ready for your banner and then visit `http://localhost:8080` in your web browser.

You should see a simple animated banner. At this point, you're on your own to customize it. As you customize the code, your browser will reload to show you the new version of your banner.

### Step 4

When you are finished customizing, press `CTL-C` once to stop the dev server. You will still be in your Docker container. Then type `gulp build` and your banner will be compressed and optimized in the `dist` directory.
