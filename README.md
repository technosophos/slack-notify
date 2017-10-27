# Slack-Notify

Slack-Notify is a very simple tool for sending a Slack notification via a
Slack Incoming Webhook.

It is designed to function as a 12-factor app, receiving configuration via
environment variables. To keep things simple, it is rigid in what it allows you
to set. More complex slackbots might want to customize this a little more.

## Slack Incoming Webhooks

This tool uses [Slack Incoming Webhooks](https://api.slack.com/incoming-webhooks)
to send a message to your slack channel.

Before you can use this tool, you need to log into your Slack account and configure
this.

## Usage

Running `slack-notify` in a shell prompt goes like this:

```console
$ export SLACK_WEBHOOK=https://hooks.slack.com/services/Txxxxxx/Bxxxxxx/xxxxxxxx
$ SLACK_MESSAGE="hello" slack-notify
```

Running the Docker container goes like this:

```console
$ export SLACK_WEBHOOK=https://hooks.slack.com/services/Txxxxxx/Bxxxxxx/xxxxxxxx
$ docker run -e SLACK_WEBHOOK=$SLACK_WEBHOOK -e SLACK_MESSAGE="hello" -e SLACK_CHANNEL=acid technosophos/slack-notify
```

### In Brigade

You can easily use this inside of brigade hooks. Here is an example from
[hello-helm](https://github.com/technosophos/hello-helm):


```javascript
const {events, Job} = require("brigadier")

events.on("imagePush", (e, p) => {

  var slack = new Job("slack-notify", "technosophos/slack-notify:latest", ["/slack-notify"])

  // This doesn't need access to storage, so skip mounting to speed things up.
  slack.storage.enabled = false
  slack.env = {
    // It's best to store the slack webhook URL in a project's secrets.
    SLACK_WEBHOOK: p.secrets.SLACK_WEBHOOK,
    SLACK_USERNAME: "MyBot",
    SLACK_TITLE: "Message Title",
    SLACK_MESSAGE: "Message Body",
    SLACK_COLOR: "#0000ff"
  }
  slack.run()
})
```



## Environment Variables

```shell
# The Slack-assigned webhook
SLACK_WEBHOOK=https://hooks.slack.com/services/Txxxxxx/Bxxxxxx/xxxxxxxx
# A URL to an icon
SLACK_ICON=http://example.com/icon.png
# The channel to send the message to (if omitted, use Slack-configured default)
SLACK_CHANNEL=example
# The title of the message
SLACK_TITLE="Hello World"
# The body of the message
SLACK_MESSAGE="Today is a fine day"
# RGB color to for message formatting. (Slack determines what is colored by this)
SLACK_COLOR="#efefef"
# The name of the sender of the message. Does not need to be a "real" username
SLACK_USERNAME"
```

## Build It

Configure:

```
make bootstrap
```

Compile:

```
make build
```

Publish to DockerHub

```
make docker-build docker-push
```


