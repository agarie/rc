" https://habamax.github.io/2019/03/07/vim-markdown-frontmatter.html
unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontMatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
