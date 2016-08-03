autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$(git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == *"nothing to commit"* ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$(git symbolic-ref HEAD 2>/dev/null) || return
 echo "${ref#refs/heads/}"
}

unpushed () {
  git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

rb_prompt(){
  if $(which rbenv &> /dev/null)
  then
    echo "rb: %{$fg_bold[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  else
    echo ""
  fi
}

virtual_env(){
  if [[  $VIRTUAL_ENV == "" ]]
  then
    echo ""
  else
    echo " (py: %{$fg_bold[yellow]%}$(basename "$VIRTUAL_ENV"))%{$reset_color%}"
  fi
}


directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

export PROMPT=$'\n[$(rb_prompt) $(virtual_env)] in $(directory_name) $(git_dirty)$(need_push)\n› '
## Using a newline in here requirs a change to sublime text, if you want to run ruby test.
## Should should be to change line 45 of exec.py, found in 
# ~/Library/Application Support/Sublime Text 2/Packages/Default, to:
# os.path.expandvars(v.decode(sys.getfilesystemencoding())).encode(sys.getfilesystemencoding())
# compile the py to pyc using:
# $ python
# >>> import py_compile
# >>> py_compile.compile('exec.y')
