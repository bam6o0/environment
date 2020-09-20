# environment

## How to setup environment

```
$ sh environment_setup.sh
```

## How to manage vim-package

### Install plugin
```
$ mkdir -p .vim/pack/{GITHUB_USERNAME}/start # Init load
# or optional load
$ mkdir -p .vim/pack/{GITHUE_USERNAME}/opt
$ git submodule add https://github.com/{GITHUB_USERNAME}/bam6o0-vim.git .vim/pack/{GITHUB_USERNAME}/start/bam6o0-vim
$ git commit -m 'add bam6o0-vim plugin.'
```

### Optional load plugin
`:packadd target-plugin`

### Update plugin
```
$ git submodule foreach git pull
$ git commit -a -m 'update all vim plugins.'
```

### VM for develop
```
$ vagrant up
```

## License

[MIT License](LICENSE)
