# Vapor SlackBot

You'll probably want to start w/ the slack documentation: https://api.slack.com/bot-users.

You can come say hello to this bot running on heroku in our slack as myrtle: http://slack.qutheory.io/

## 🦄 Deploy

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

#### ⚠️ Note

Heroku won't automatically scale dynos for your bot. After the build is complete, you'll need to start the process.

![start heroku bot process](/heroku-start-bot.gif)

## 🚦 Environment

| Xcode | Swift Version |
|:-:|:-:|
| 8 | DEVELOPMENT-SNAPSHOT-2016-06-20-a |

Setup Xcode by running `swift package generate-xcodeproj`

### 🔑 Bot Token

Once you have setup your bot-token, create a folder named `Config` and place a file `bot-config.json` in it. The green check marks are because I sync w/ Dropbox, they can be ignored.

![Alt text](/Images/config-structure.png?raw=true "Optional Title")

Your `bot-config.json` file should look like this (replace your token)

```
{
  "token": "<#your token here#>"
}
```

## 🏃 Run

Once the environment is configured, as above, your bot should run in Xcode. Direct message your bot in slack w/ a `hello` prefix and there will be a hello response.

## 🛠 Manually Deploy

If you'd prefer to build to Heroku manually

#### Config Token

Add your secret token (or through Heroku WebSite):

```
heroku config:set BOT_TOKEN=<#your-token-here#>
```

#### Set Buildpack

```
heroku buildpacks:set https://github.com/kylef/heroku-buildpack-swift
```

#### Procfile

Already included in project, should be `worker` type.

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
