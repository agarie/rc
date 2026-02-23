" https://www.maero.dk/markdown-frontmatter-syntax-highlighting/
unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontMatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
