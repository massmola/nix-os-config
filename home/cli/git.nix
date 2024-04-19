{pkgs, ...}: {
  home.packages = with pkgs; [zsh-forgit gitflow];
  programs.git = {
    enable = true;
    userName = "MassimiIano";
    userEmail = "massimiliano.mola.bzs@gmail.com";
    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "*.elc"
      "auto-save-list"
      ".direnv/"
      ".venv/"
      ".vscode/"
      "node_modules"
      "result"
      "result-*"
    ];
    extraConfig = {
      init = {defaultBranch = "main";};
      delta = {
        options.map-styles = "bold purple => syntax #ca9ee6, bold cyan => syntax #8caaee";
        line-numbers = true;
      };
    };
    aliases = {
      essa = "push --force";
      co = "checkout";
      fuck = "commit --amend -m";
      c = "commit -m";
      ca = "commit -am";
      forgor = "commit --amend --no-edit";
      graph = "log --all --decorate --graph --oneline";
      oops = "checkout --";
      l = "log";
      r = "rebase";
      s = "status --short";
      ss = "status";
      d = "diff";
      st = "status";
      br = "branch";
      # df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
      # hist = ''
      #   log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all'';
      # llog = ''
      #   log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative'';
      # edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; hx `f`";
    };
  };
}