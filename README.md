## gitgoggle
- simple github web hook processor

#### how to install
```
bundle install --path=vendor/bundle --binstubs=bin
```
#### how to config
- server configuration
 - modify thin.yml
 - more detail, see thin document
- hook configuration
 - create directory under  

#### how to run
```
rake start
```
- log output is log/thin.{port}.log

#### how to stop
```
rake stop
```

