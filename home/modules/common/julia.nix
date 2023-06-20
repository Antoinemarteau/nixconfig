{ pkgs, config, ... }:
{

    imports = [ ./neovim/plugins/julia-cell.nix ];

    programs.nixvim = {
        plugins = {
            # Parser
            treesitter.grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [ julia ];

            # LanguageServer
            lsp.servers.julials.enable = true;
        };

        # julia-vim
        extraPlugins = [ pkgs.vimPlugins.julia-vim ];
        globals.latex_to_unicode_keymap = true;
    };

    home = {
        shellAliases = {
            ju = "julia";
        };

        sessionVariables = {
            JULIA_LOAD_PATH = "$HOME/prog/these/julia:$JULIA_LOAD_PATH";
        };

        packages = with pkgs; [ julia-bin ];

        file = {
            startup = {
                executable = true;
                text = ''
                    ENV["JULIA_EDITOR"] = "vim"
                    ENV["JULIA_NUM_THREADS"] = 4

                    import Pkg as var"#Pkg"
                    let
                        pkgs = ["Revise", "OhMyREPL", "BenchmarkTools", "Cthulhu", "Debugger", "Profile", "ProfileView"]
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

                    @sync @eval begin
                        @async @eval using Revise
                        @async @eval using OhMyREPL
                    end

                    if Base.isinteractive() &&
                      (local REPL = get(Base.loaded_modules, Base.PkgId(Base.UUID("3fa0cd96-eef1-5676-8a61-b3b8758bbffb"), "REPL"), nothing); REPL !== nothing)
                        # Source: https://github.com/fredrikekre/.dotfiles/blob/master/.julia/config/startup.jl
                        # Automatically load tooling on demand:
                        # - BenchmarkTools.jl when encountering @btime or @benchmark
                        # - Cthulhu.jl when encountering @descend(_code_(typed|warntype))
                        # - Debugger.jl when encountering @enter or @run
                        # - Profile.jl when encountering @profile
                        # - ProfileView.jl when encountering @profview
                        local tooling_dict = Dict{Symbol,Vector{Symbol}}(
                            :BenchmarkTools => Symbol.(["@btime", "@benchmark"]),
                            :Cthulhu        => Symbol.(["@descend", "@descend_code_typed", "@descend_code_warntype"]),
                            :Debugger       => Symbol.(["@enter", "@run"]),
                            :Profile        => Symbol.(["@profile"]),
                            :ProfileView    => Symbol.(["@profview"]),
                        )
                        pushfirst!(REPL.repl_ast_transforms, function(ast::Union{Expr,Nothing})
                            function contains_macro(ast, m)
                                return ast isa Expr && (
                                    (Meta.isexpr(ast, :macrocall) && ast.args[1] === m) ||
                                    any(x -> contains_macro(x, m), ast.args)
                                )
                            end
                            for (mod, macros) in tooling_dict
                                if any(contains_macro(ast, s) for s in macros) && !isdefined(Main, mod)
                                    @info "Loading $mod ..."
                                    try
                                        Core.eval(Main, :(using $mod))
                                    catch err
                                        @info "Failed to automatically load $mod" exception=err
                                    end
                                end
                            end
                            return ast
                        end)
                    end

                    if isfile("Project.toml") && isfile("Manifest.toml")
                        var"#Pkg".activate(".")
                    end
                '';
                target = ".julia/config/startup.jl";
            };
        };
    };
}
