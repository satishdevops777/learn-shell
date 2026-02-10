#!/bin/bash
curl -X POST -H 'Content-type: application/json' --data '{"text":"Service is down!"}' https://hooks.slack.com/services/your/webhook/url
