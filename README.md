# Vapor SlackBot

You'll probably want to start w/ the slack documentation: https://api.slack.com/bot-users.

You can come say hello to this bot running on heroku in our slack as myrtle: http://slack.qutheory.io/

### Environment

| Xcode | Swift Version |
|:-:|:-:|
| 7.3 | DEVELOPMENT-SNAPSHOT-2016-06-06-a |

Setup Xcode by running `swift package generate-xcodeproj`

> NOTE: If you get errors running this command, it's likely because Xcode 8 is installed, run the following command: `xcode-select -s /Applications/Xcode.app/`. We will support Xcode 8 on next release.

#### Bot Token

Once you have setup your bot-token, create a folder named `Config` and place a file `bot-config.json` in it. The green check marks are because I sync w/ Dropbox, they can be ignored.

![Alt text](/Images/config-structure.png?raw=true "Optional Title")

Your `bot-config.json` file should look like this (replace your token)

```
{
  "token": "<#your token here#>"
}
```

### Run

Once the environment is configured, as above, your bot should run in Xcode. Direct message your bot in slack w/ a `hello` prefix and there will be a hello response.

### Heroku

This bot is currently running on heroku. It has a Procfile and is ready to setup.

#### Create Heroku App

Create your app on Heroku.com

#### Config Token

Add your secret token:

```
heroku config:set BOT_TOKEN=<#your-token-here#>
```

#### Set Buildpack

```
heroku buildpacks:set https://github.com/kylef/heroku-buildpack-swift
```

#### Push To Heroku

Commit uncommmitted changes if necessary, then push to Heroku

```
git push heroku master
```

#### Scale Up Dyno

Scale up a worker with:

```
heroku ps:scale worker=1
```

### Author

Created by <a href="https://twitter.com/@logmaestro">Logan Wright</a>
