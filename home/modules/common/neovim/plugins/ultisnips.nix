{ pkgs, ... }:
{
  programs.nixvim = {

    extraPlugins = [
      pkgs.vimPlugins.ultisnips
    ];

    globals = {
      UltiSnipsEditSplit           = "horizontal";
      UltiSnipsExpandTrigger       = "<tab>";
      UltiSnipsJumpForwardTrigger  = "<tab>";
      UltiSnipsJumpBackwardTrigger = "<s-tab>";
    };

    autoCmd = [
        # .pro (getDP) snippets priority : pro > onelab > all (discard any others)
        {
            event = [ "BufNewFile" "BufReadPost" ] ;
            pattern = "*.pro";
            command = "UltiSnipsAddFiletypes pro.onelab";
        }
        {
            event = [ "BufNewFile" "BufReadPost" ] ;
            pattern = "*.pro";
            command = "UltiSnipsAddFiletypes onelab.all";
        }
        # .geo (gmsh)  snippets priority : geo > onelab > all (discard any others)
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
  };
}
