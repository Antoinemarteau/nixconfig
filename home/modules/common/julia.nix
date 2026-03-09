{ pkgs, config, lib, ... }:
{

    programs.scientific-fhs = {
      enable = true;
      juliaVersions = [
        {
          version = "1.12.5";
          default = true;
        }
    (lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME ["monash" "framework"] ) { version = "1.11.5"; })
    (lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME ["monash" "framework"] ) { version = "1.10.10";})
    #(lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME ["monash"] ) { version = "1.9.4"; })
    #(lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME ["monash"] ) { version = "1.8.3"; })
      ];
      enableNVIDIA = false;
    };

    home = {
        shellAliases.ju  = "julia -t auto";
        shellAliases.jug = "julia -t auto -i -e \"using Gridap; " +
          "using Gridap.Helpers;     using Gridap.Io;            using Gridap.Algebra;" +
          "using Gridap.Arrays;      using Gridap.TensorValues;  using Gridap.Fields;" +
          "using Gridap.Polynomials; using Gridap.ReferenceFEs;  using Gridap.Geometry;" +
          "using Gridap.CellData;    using Gridap.Visualization; using Gridap.FESpaces;" +
          "using Gridap.MultiField;  using Gridap.ODEs;          using Gridap.Adaptivity;\" ";

        shellAliases.pluto = "julia -e \"using Pluto; Pluto.run()\" &> /dev/null &";

        # If stop using scientific-fhs, julia and OpenGL lib are needed
        #shellAliases.ju = "LD_LIBRARY_PATH=/run/opengl-driver/lib/ julia";
        #packages = with pkgs; [ julia-bin ];

        sessionVariables = {
            JULIA_LOAD_PATH = "$HOME/prog/these/julia:$JULIA_LOAD_PATH";
        };

        file = {
            nix_ld_jetls = { # wrapp JETLS using nix-ld
                executable = true;
                text = ''
                    #!/bin/sh
                    export NIX_LD_LIBRARY_PATH=~/.julia/bin/jetls
                    exec ~/.julia/bin/jetls "$@"
                '';
                target = ".local/bin/nix_ld_jetls";
            };

            startup = {
                executable = true;
                text = ''
                    if isinteractive()
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

                            # JETLS.jl
                            #if isnothing(var"#Pkg".App.status( var"#Pkg".PackageSpec("JETLS")))
                            ## This either installs or updates JETLS
                            redirect_stderr(devnull) do # makes it silent
                              var"#Pkg".Apps.add(; url="https://github.com/aviatesk/JETLS.jl", rev="2026-02-27")
                            end
                            #end

                            # LanguageServer.jl
                            # it should be installed in special folder for neovim
                            mkpath("/home/antoine/.julia/environments/nvim-lspconfig")
                            var"#Pkg".activate("/home/antoine/.julia/environments/nvim-lspconfig")
                            if isnothing(Base.find_package("LanguageServer"))
                                var"#Pkg".add("LanguageServer")
                            end
                            if isnothing(Base.find_package("SymbolServer"))
                                var"#Pkg".add("SymbolServer")
                            end
                            if isnothing(Base.find_package("StaticLint"))
                                var"#Pkg".add("StaticLint")
                            end
                            var"#Pkg".activate()
                        end

                        using Revise

                        if isfile("Project.toml") #&& isfile("Manifest.toml")
                            var"#Pkg".activate(".")
                        end

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
                            ["MVector", "SVector", "MMatrix", "SMatrix", "MArray", "SArray"] =>
                                                        :(using StaticArrays),

                           #["pager"]                => :(using TerminalPager),
                           #["cowsay"]               => :(cowsay(x) = println("Cow: \"$x\"")),
                        ])
                    end
                '';
                target = ".julia/config/startup.jl";
            };
        };
    };
}
