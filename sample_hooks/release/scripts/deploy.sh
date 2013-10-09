#!/bin/bash

echo "deploy server with $1"

pushd ~/caravan-heroes/deploy
bundle exec cap prod app:deploy -s deploy_branch=$1
popd

