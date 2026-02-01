{ pkgs, config, lib, ... }:
{

    programs.scientific-fhs = {
      enable = true;
      juliaVersions = [
        {
          version = "1.12.1";
          default = true;
        }
    (lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME ["monash" "framework"] )
        { version = "1.11.5"; }
    )
    (lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME ["monash" "framework"] )
        { version = "1.10.10"; }
    )
    #(lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME ["monash"] ) { version = "1.9.4"; })
    #(lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME ["monash"] ) { version = "1.8.3"; })
      ];
      enableNVIDIA = false;
    };

    home = {
        shellAliases.ju  = "julia -t auto";
        shellAliases.jug = "julia -t auto -i -e \"using Gridap; " +
          "using Gridap.Helpers;      using Gridap.Arrays;      using Gridap.Algebra;" +
          "using Gridap.TensorValues; using Gridap.Polynomials; using Gridap.ReferenceFEs\" ";

        shellAliases.pluto = "julia -e \"using Pluto; Pluto.run()\" &> /dev/null &";

        # If stop using scientific-fhs, julia and OpenGL lib are needed
        #shellAliases.ju = "LD_LIBRARY_PATH=/run/opengl-driver/lib/ julia";
        #packages = with pkgs; [ julia-bin ];

        sessionVariables = {
            JULIA_LOAD_PATH = "$HOME/prog/these/julia:$JULIA_LOAD_PATH";
        };

        file = {
            startup = {
                executable = true;
                text = ''
                    ENV["JULIA_EDITOR"] = "nvim"

                    import Pkg as var"#Pkg"

                    let
                        pkgs = [
                            "BasicAutoloads", "Revise", "OhMyREPL",
                            "BenchmarkTools", "Chairmarks", "Cthulhu", "Debugger",
                            "Profile", "ProfileView", "Test", "StaticArrays",
                            "LinearAlgebra", "About"
                        ]
                        for pkg in pkgs
                            if Base.find_package(pkg) === nothing
                                var"#Pkg".add(pkg)
                            end
                        end

                        # LanguageServer should be installed in special
                        # folder for neovim
                        mkpath("/home/antoine/.julia/environments/nvim-lspconfig")
                        var"#Pkg".activate("/home/antoine/.julia/environments/nvim-lspconfig")
                        if Base.find_package("LanguageServer") === nothing
                            var"#Pkg".add("LanguageServer")
                        end
                        var"#Pkg".activate()
                    end

                    @async @eval using Revise
                    #using OhMyREPL

                    if isinteractive()
                        import BasicAutoloads
                        BasicAutoloads.register_autoloads([
                            ["@btime", "@benchmark"] => :(using BenchmarkTools),
                            ["@b", "@be"]            => :(using Chairmarks),
                            ["@test", "@testset", "@test_broken", "@test_deprecated", "@test_logs",
                            "@test_nowarn", "@test_skip", "@test_throws", "@test_warn", "@inferred"]
                                                     => :(using Test),
                            ["@descend", "@descend_code_typed", "@descend_code_warntype"] =>
                                                        :(using Cthulhu),
                            ["@enter", "@run"]       => :(using Debugger),
                            ["@profile"]             => :(using Profile),
                            ["@profview", "@profview_allocs"]
                                                     => :(using ProfileView),
                            ["norm", "I"]            => :(using LinearAlgebra),
                            ["about"]                => :(using About),

                           #["pager"]                => :(using TerminalPager),
                           #["cowsay"]               => :(cowsay(x) = println("Cow: \"$x\"")),
                        ])
                    end

                    if isfile("Project.toml") #&& isfile("Manifest.toml")
                        var"#Pkg".activate(".")
                    end
                '';
                target = ".julia/config/startup.jl";
            };
        };
    };
}
