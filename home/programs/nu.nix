{
  programs.nushell = {
    enable = true;
    extraConfig = ''
           let carapace_completer = {|spans|
           carapace $spans.0 nushell ...$spans | from json
           }
           $env.config = {
            show_banner: false,
            completions: {
            case_sensitive: false # case-sensitive completions
            quick: true    # set to false to prevent auto-selecting completions
            partial: true    # set to false to prevent partial filling of the prompt
            algorithm: "fuzzy"    # prefix or fuzzy
            external: {
            # set to false to prevent nushell looking into $env.PATH to find more suggestions
                enable: true
            # set to lower can improve completion performance at the cost of omitting some options
                max_results: 100
                completer: $carapace_completer # check 'carapace_completer'
              }
            }
           }

           # Custom prompt to show full path with lambda symbol
           $env.PROMPT_COMMAND = {||
               $"(ansi green_bold)($env.PWD)(ansi reset) λ "
           }

           $env.PROMPT_INDICATOR = "λ "
           $env.PROMPT_INDICATOR_VI_INSERT = "λ "
           $env.PROMPT_INDICATOR_VI_NORMAL = "λ "
           $env.PATH = ($env.PATH |
           split row (char esep) |
           prepend /home/myuser/.apps |
           append /usr/bin/env
           )
           '';
  };
  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

            programs.starship = { enable = true;
                settings = {
                  add_newline = true;
                  character = {
                  success_symbol = "[λ](bold green)";
                  error_symbol = "[λ](bold red)";
                };
             };
           };
}
