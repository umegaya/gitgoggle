#!/bin/bash

echo "deploy server"

pushd ~/your_app/deploy
bundle exec cap prod app:deploy
popd

