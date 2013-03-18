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
    if [[ $st == "nothing to commit, working directory clean" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$(git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
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

rvm_prompt() {
  echo "%{$fg_bold[magenta]%}$(~/.rvm/bin/rvm-prompt)%{$reset_color%}"
}


# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

export PROMPT=$'\n$(rvm_prompt) in $(directory_name) $(git_dirty)$(need_push)\n› '
## Using a newline in here requirs a change to sublime text, if you want to run ruby test.
## Should should be to change line 45 of exec.py, found in 
# ~/Library/Application Support/Sublime Text 2/Packages/Default, to:
# os.path.expandvars(v.decode(sys.getfilesystemencoding())).encode(sys.getfilesystemencoding())
# compile the py to pyc using:
# $ python
# >>> import py_compile
# >>> py_compile.compile('exec.y')
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}$(todo)%{$reset_color%}"
}

precmd() {
  set_prompt
}
