## gitgoggle
- simple github web hook processor
- matching commited branch name and running corresponding script with specified user

#### how to install

```
bundle install --path=vendor/bundle --binstubs=bin
cp sample_settings.json settings.json
(modify settings.json according to your needs (also prepare for hook scripts))
rake start
```

#### how to config
- server configuration
 - modify thin.yml
 - more detail, see thin document
- hook configuration
 - copy sample_settings.json to settings.json and modify it according to your needs.

```
# sample_settings.json
{
 # this is regexp to matching commited branch name (use \\ to escape control character)
 "refs/tags/release/[0-9\\-/]*$":[
  # ["{script directory or file}", "execution user name (if omitted, same user as running gitgoggle)"]
  ["sample_hooks/release", "root"]
 ],
 "refs/heads/master":[
  ["sample_hooks/master/runtest.rb"]
 ]
}
```

#### about hook script
- currently .rb and .sh are supported
- .rb and .sh is executed by folowing commandline
 - .rb : runuser -l {user} -c "ruby {script} {url encoded JSON string}"
 - .sh : runuser -l {user} -c "./{script} {url encoded JSON string}"

#### how to run

```
rake start
```
- log output under log/thin.{port}.log

#### how to stop

```
rake stop
```

