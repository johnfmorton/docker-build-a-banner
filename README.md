# Docker: Build A Banner

## About

This Dockerfile builds an image to run Yeoman and the Build A Banner generator in a Docker container.

```
alias banner='docker container run -p 8080:8080/tcp -p 35729:35729/tcp -v "$PWD":/app -it --rm buildabanner'
```
### Building your own image from this Dockerfile

```
docker image build -t buildabanner .
```

Then test your image. From your terminal, go into a new blank directory, then type the following:

```
docker container run -p 8080:8080/tcp -p 35729:35729/tcp -v "$PWD":/app -it --rm buildabanner
```

You should be presented with a new command prompt. At this point, you're inside the Docker container. Type `yo buildabanner` and you should be presented with the normal Build A Banner prompts.

Once you are done, you can use the normal BAB commands, `gulp`, `gulp build`, `gulp archive`, and `gulp ba`.

When you are done, you can exit the container with CTL-C. The container will stop, but your files for the banner will still be on your hard drive.

When you want to work on them again, navigate back to that directory in your terminal and type the same command again to bring back the Docker container.

```
docker container run -p 8080:8080/tcp -v "$PWD":/app -it --rm buildabanner
```
Since this command is hard to remember, in your `rc` file, make an alias for it like this:

```
alias banner='docker container run -p 8080:8080/tcp -p 35729:35729/tcp -v "$PWD":/app -it --rm buildabanner'
```

It is probably easier to just use my version from Docker Hub, [johnfmorton/yo-buildabanner](https://hub.docker.com/r/johnfmorton/yo-buildabanner).

```
alias banner='docker container run -p 8080:8080/tcp -p 35729:35729/tcp -v "$PWD":/app -it --rm johnfmorton/yo-buildabanner:beta
```

I also keep another alias that will update the image. The only difference is the addtional `--pull always` flag. There is no option to only pull when the image is updated, so you must check manually.

```
alias bannerupdate='docker container run -p 8080:8080 -p 35729:35729 -v "$PWD":/app -it --pull always --rm johnfmorton/yo-buildabanner:beta'
```

After you open a new terminal window, this alias will be available and you can just type `banner` in the folder to get to work.
