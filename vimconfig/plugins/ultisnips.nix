{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.ultisnips
  ];

  globals = {
    UltiSnipsEditSplit           = "horizontal";
    UltiSnipsExpandTrigger       = "<tab>";
    UltiSnipsJumpForwardTrigger  = "<tab>";
    UltiSnipsJumpBackwardTrigger = "<s-tab>";
    UltiSnipsSnippetDirectories  = [ ../nvim/UltiSnips ];
  };

  autoCmd = [
      # .pro and .dat (getDP) snippets priority : pro > onelab > all (discard any others)
      {
          event = [ "BufNewFile" "BufReadPost" ] ;
          pattern = "*.{pro,dat}";
          command = "UltiSnipsAddFiletypes pro.onelab";
      }
      {
          event = [ "BufNewFile" "BufReadPost" ] ;
          pattern = "*.{pro,dat}";
          command = "UltiSnipsAddFiletypes onelab.all";
      }
      {
          event = [ "BufNewFile" "BufReadPost" ] ;
          pattern = "*.geo";
          command = "UltiSnipsAddFiletypes geo.onelab";
      }
      {
          event = [ "BufNewFile" "BufReadPost" ] ;
          pattern = "*.geo";
          command = "UltiSnipsAddFiletypes onelab.all";
      }
  ];
}
